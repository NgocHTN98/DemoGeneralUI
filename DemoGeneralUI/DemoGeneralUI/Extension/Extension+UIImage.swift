//
//  Extension+UIImage.swift
//  Hi FPT
//
//  Created by Lam Quoc on 27/07/2021.
//

import UIKit

extension UIImage {
    func getFileSizeInfo(allowedUnits: ByteCountFormatter.Units = .useMB,
                         countStyle: ByteCountFormatter.CountStyle = .memory,
                         compressionQuality: CGFloat = 1.0) -> String? {
        // https://developer.apple.com/documentation/foundation/bytecountformatter
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.countStyle = countStyle
        return getSizeInfo(formatter: formatter, compressionQuality: compressionQuality)
    }

    func getSizeInfo(formatter: ByteCountFormatter, compressionQuality: CGFloat = 1.0) -> String? {
        guard let imageData = jpegData(compressionQuality: compressionQuality) else { return nil }
        return formatter.string(fromByteCount: Int64(imageData.count))
    }
    
    func resizeWithScaleAspectFitMode(to dimension: CGFloat) -> UIImage? {

        if max(size.width, size.height) <= dimension { return self }

        var newSize: CGSize!
        let aspectRatio = size.width/size.height

        if aspectRatio > 1 {
            // Landscape image
            newSize = CGSize(width: dimension, height: dimension / aspectRatio)
        } else {
            // Portrait image
            newSize = CGSize(width: dimension * aspectRatio, height: dimension)
        }

        return resizeWithUIKit(to: newSize)
    }

    // MARK: - UIKit
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithUIKit(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func convertImageToBase64String() -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    // image with rounded corners
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func toRectangle() -> UIImage? {
        var isPortrait:  Bool    { size.height > size.width }
        var isLandscape: Bool    { size.width > size.height }
        var breadth:     CGFloat { min(size.width, size.height) }
        var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
        
        let isOpaque: Bool = false
        
        guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }
    
    func getSizeIn(_ type: DataUnits)-> Double {
        guard let data = self.jpegData(compressionQuality: 1) else {
            return 0.0
        }
        var size: Double = 0.0
        
        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }
        return  size
    }
    func caculateScaleImage(maxSizeByte : Int)-> Double{
        for i in (1...10).reversed(){
            if let size = self.jpegData(compressionQuality: Double(i)/10.0) {
                if Double(size.count) <= Double(maxSizeByte){
                    return Double(i)/10.0
                }
            }
        }
        return 0.0
    }
}
extension UIImage {
    func resized(toSize size: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let canvas: CGSize
        if width <= size && height <= size {
            return self
        } else if width > height {
            canvas = CGSize(width: size, height: CGFloat(ceil(size/width * height)))
        } else {
            canvas = CGSize(width: CGFloat(ceil(size/height * width)), height: size)
        }
        
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func fixOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform
                .translatedBy(x: size.width, y: size.height).rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).rotated(by: .pi)
        case .right, .rightMirrored:
            transform = transform
                .translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
        case .upMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        guard
            let cgImage = cgImage,
            let colorSpace = cgImage.colorSpace,
            let context = CGContext(
                data: nil, width: Int(size.width), height: Int(size.height),
                bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue
            )
        else { return self }
        context.concatenate(transform)
        
        var rect: CGRect
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
        default:
            rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        context.draw(cgImage, in: rect)
        return context.makeImage().map { UIImage(cgImage: $0) } ?? self
    }
    
    func cropOCRImage(frame : CGRect) -> UIImage? {

        guard let cgImage = cgImage else {
            return nil
        }
        let width : Double = Double(cgImage.width) - (frame.minX * 2.0) // tinh width theo hinh anh thuc te  
        let frameCrop = CGRect(x: frame.minX, y: frame.minY, width: width, height: frame.height + 10)
        guard let newCgImage = cgImage.cropping(to: frameCrop) else {
            return nil
        }

        return UIImage(cgImage: newCgImage, scale: scale, orientation: imageOrientation)
    }
    
    func withTintColor(uiColor color: UIColor) -> UIImage {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        } else {
            let tempImage = self.withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView(image: tempImage)
            imageView.tintColor = color
            return imageView.image ?? UIImage()
        }
    }
    
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
        let newHeight = size.height * newWidth / size.width

        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
