//
//  Extension+Numeric.swift
//  Hi FPT
//
//  Created by GiaNH3 on 7/18/21.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? "" }
}
