//
//  StackStatusCltCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/8/23.
//

import Foundation
import UIKit

class StackStatusCltCell: UICollectionViewCell{
    
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
        
    }
}
