//
//  Extension+UILabel.swift
//  Hi FPT
//
//  Created by GiaNH3 on 8/9/21.
//

import UIKit
extension UILabel {
    func isTruncated() -> Bool {
        
        layoutIfNeeded()
        let heightThatFits = sizeThatFits(bounds.size).height
        return heightThatFits > bounds.size.height
        
    }
    func setupRequired(){
        let attr = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        let mulAttr = NSMutableAttributedString(string: self.text ?? "")
        mulAttr.append(attr)
        self.attributedText = mulAttr
    }
}

