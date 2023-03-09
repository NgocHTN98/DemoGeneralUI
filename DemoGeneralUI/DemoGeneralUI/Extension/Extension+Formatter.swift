//
//  Extension+Formatter.swift
//  Hi FPT
//
//  Created by GiaNH3 on 7/18/21.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
