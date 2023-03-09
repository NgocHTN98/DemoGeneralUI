//
//  Extension.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 09/03/2023.
//

import Foundation
import UIKit

extension UILabel{
    func parseLabel(attr: AttributeRes){
        self.numberOfLines = attr.maxLines ?? 0
        
        if attr.type == .Text{
            self.text = attr.text_content
            self.textColor = UIColor().hexStringToUIColor(hex: attr.text_color ?? "#FFFFFF")
            self.font = UIFont(name: "System", size: CGFloat(attr.size ?? 0))
            
            return
        }
        
        if attr.type == .TextMultiStyle{
            let str = NSMutableAttributedString()
            for item in attr.attributes?.items ?? []{
                
                switch (item.type){
                case .Text:
                    let attrText = NSAttributedString(string: item.text_content ?? "")
                    str.append(attrText)
                    break
                case .Image:
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: item.image_name ?? "")
                    let attachmentString = NSAttributedString(attachment: attachment)
                    str.append(attachmentString)
                    break
                default:
                    return
                }
                
            }
            
            self.attributedText = str
            return
        }
    }
    
}

extension UIImageView{
    func parseImg(attr: AttributeRes){
        self.image = UIImage(named: attr.image_name ?? "")
    }
}
