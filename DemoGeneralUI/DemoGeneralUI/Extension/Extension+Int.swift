//
//  Extension+Int.swift
//  Hi FPT
//
//  Created by GiaNH3 on 8/17/21.
//

import UIKit
extension Int {
    var toUIColor: UIColor {
        let r = (CGFloat)(((self & 0xFF0000) >> 16)) / 255.0
        let g = (CGFloat)(((self & 0x00FF00) >> 08)) / 255.0
        let b = (CGFloat)(((self & 0x0000FF) >> 00)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    var formatnumber: String {
            let formater = NumberFormatter()
            formater.groupingSeparator = "."
            formater.numberStyle = .decimal
            return formater.string(from: NSNumber(value: self))!
    }
    
    var positiveInt : Int{
        return self < 0 ? 0 : self
    }
}
