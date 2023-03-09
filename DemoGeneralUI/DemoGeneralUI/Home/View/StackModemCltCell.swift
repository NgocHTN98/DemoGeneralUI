//
//  StackModemCltCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class StackModemCltCell:UICollectionViewCell{
    

    @IBOutlet weak var vBground: StackModemView!
    
    var vm: AttributeRes?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){

        vBground.vm = vm
    }
    

}

