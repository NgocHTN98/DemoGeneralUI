//
//  Extension+UIColor.swift
//  Hi FPT
//
//  Created by Lam Quoc on 19/07/2021.
//

import Foundation
import UIKit

extension UIColor {
    static let hiPrimary = #colorLiteral(red: 0.2705882353, green: 0.3921568627, blue: 0.9294117647, alpha: 1)
    static let hiBackground = #colorLiteral(red: 0.937254902, green: 0.9568627451, blue: 1, alpha: 1)
    static let textHint = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    static let textGrey = #colorLiteral(red: 0.462745098, green: 0.462745098, blue: 0.462745098, alpha: 1)
    static let aaaaaa = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    static let eeeeee = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    static let eaeaea = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
    static let bdbdbd = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    static let dddddd = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    convenience init(netHex:Int) {
        self.init(r:(netHex >> 16) & 0xff, g:(netHex >> 8) & 0xff, b:netHex & 0xff)
    }
}

public extension UIColor {
    static var btnDisable: UIColor  { return #colorLiteral(red: 0.7803921569, green: 0.7960784314, blue: 0.8117647059, alpha: 1) }
    static var btnEnable: UIColor { return #colorLiteral(red: 0.2705882353, green: 0.3921568627, blue: 0.9294117647, alpha: 1) }
}
