//
//  Extension+Element.swift
//  Hi FPT
//
//  Created by GiaNH3 on 8/16/21.
//

import Foundation
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
