//
//  Extension+Data.swift
//  Hi FPT
//
//  Created by Lam Quoc on 19/07/2021.
//

import Foundation
extension Data {
    var htmlToAttributedString: NSMutableAttributedString? {
        do {
            return try NSMutableAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error: ", error)
            return  nil
        }
    }
}
