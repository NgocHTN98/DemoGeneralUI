//
//  StackStatusCltCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/8/23.
//

import Foundation
import UIKit

class StackStatusCltCell: UICollectionViewCell{
    
    var vm: AttributeRes?
    
    @IBOutlet weak var imgleft: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
    
    func setupUi(){
        guard let vm = vm else {
            return
        }
        
        for item in vm.attributes?.items ?? [] {
            let id = StackStatusId(rawValue: item.id ?? "none") ?? .none
            switch(id){
            case .icon_wifi:
                imgleft.parseImg(attr: item)
                break
            case .icon_reload:
                imgRight.parseImg(attr: item)
                break
            case .modem_title:
                lbTitle.parseLabel(attr: item)
                break
            case .modem_status:
                lbDescription.parseLabel(attr: item)
                break
            case .modem_name:
                lbInfo.parseLabel(attr: item)
                break
            case .none:
                break
            }
        }
        
    }
}

enum StackStatusId:String{
    case icon_wifi
    case modem_title
    case icon_reload
    case modem_status
    case modem_name
    case none
}
