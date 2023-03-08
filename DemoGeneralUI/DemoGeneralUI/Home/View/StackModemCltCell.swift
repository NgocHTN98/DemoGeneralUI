//
//  StackModemCltCell.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class StackModemCltCell:UICollectionViewCell{
    
    weak var vContent: StackModemView!

    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        if vContent == nil {
            vContent = StackModemView()
        }
        
        addSubview(vContent)
    }
    
}

