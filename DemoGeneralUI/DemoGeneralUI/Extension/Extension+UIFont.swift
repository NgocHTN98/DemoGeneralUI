//
//  Extension+UIFont.swift
//  Hi FPT
//
//  Created by Lam Quoc on 27/07/2021.
//

import UIKit

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func boldItalic() -> UIFont {
        return withTraits(traits: [.traitBold, .traitItalic])
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
