//
//  Extension+MutableAttributedString.swift
//  Hi FPT
//
//  Created by Lam Quoc on 22/07/2021.
//

import UIKit

extension NSMutableAttributedString {
    
    @discardableResult func customeFont(_ text: String, color: UIColor, stypeFont: UIFont) -> NSMutableAttributedString {
        
        let attrs : [NSAttributedString.Key: Any] = [.font : stypeFont,.foregroundColor : color]
        let attrString = NSMutableAttributedString(string: text, attributes: attrs)
        
        append(attrString)
        
        return self
        
    }
    
    func replaceWithAttribute(fromStr: String, toStr: String , withAttribute: [NSAttributedString.Key : Any]?)  {
        let toString = NSAttributedString(string: toStr, attributes: withAttribute)
        // Get range of text to replace
        if let feeRange = self.string.range(of: fromStr) {
            let nsRange = NSRange(feeRange, in: self.string)
            self.replaceCharacters(in: nsRange, with: toString)
        }
     
    }
    
}
