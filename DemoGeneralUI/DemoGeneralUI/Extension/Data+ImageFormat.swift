//
//  Data+ImageFormat.swift
//  Hi FPT
//
//  Created by Khang L on 02/02/2023.
//

import Foundation

extension Data {
    var imageFormat: ImageFormat {
        guard let header = map({ $0 as UInt8 })[safe: 0] else {
            return .unknown
        }

        return ImageFormat(byte: header)
    }
}

enum ImageFormat: String {
    case png = ".png"
    case jpeg = ".jpeg"
    case gif = ".gif"
    case tiff = ".tiff"
    case unknown = ""

    init(byte: UInt8) {
        switch byte {
        case 0x89:
            self = .png
        case 0xFF:
            self = .jpeg
        case 0x47:
            self = .gif
        case 0x49, 0x4D:
            self = .tiff
        default:
            self = .unknown
        }
    }
}
