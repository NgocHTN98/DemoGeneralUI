//
//  StackModemTblCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/9/23.
//

import Foundation
import UIKit

class StackModemTblCell:UITableViewCell{
    
    @IBOutlet weak var lbModemTitle: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var imgModem: UIImageView!
    
    var vm: AttributeRes?{
        didSet{
            setupUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
    func setupUI(){
        guard let vm = vm else {return}
        
        for item in vm.attributes?.items ?? [] {
            let id = StackModemId(rawValue: item.id ) ?? .none
            switch(id){
            case .modem_title:
                lbModemTitle.parseLabel(attr: item)
            case .modem_description:
                lbInfo.parseLabel(attr: item)
            case .modem_detail:
                lbDetail.parseLabel(attr: item)
            case .modem_img:
                imgModem.parseImg(attr: item)
            case .none:
                return
            }
        }
    }
}

enum StackModemId: String{
    case modem_title
    case modem_description
    case modem_detail
    case modem_img
    case none
}
