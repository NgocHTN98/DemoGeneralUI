//
//  StackInfoCltCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/8/23.
//

import Foundation
import UIKit

class StackInfoCltCell: UICollectionViewCell{
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    
    @IBOutlet weak var lbDetail: UILabel!
    
    var vm: AttributeRes?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        guard let vm = vm else {return}
        
        for item in vm.attributes?.items ?? [] {
            let id = StackInfoId(rawValue: item.id ?? "none") ?? .none
            switch(id){
            case .item_title:
                lbTitle.parseLabel(attr: item)
            case .item_sub_title:
                lbSubTitle.parseLabel(attr: item)
            case .item_detail:
                lbDetail.parseLabel(attr: item)
            case .none:
                return
            }
        }

    }
}

enum StackInfoId: String{
    case item_title
    case item_sub_title
    case item_detail
    case none
}
