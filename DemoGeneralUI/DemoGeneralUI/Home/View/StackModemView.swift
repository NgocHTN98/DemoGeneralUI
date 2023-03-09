//
//  StackModemView.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class StackModemView: UIView{
    
    var vm: AttributeRes?{
        didSet{
            setupUI()
        }
    }
    
    lazy var vModemContent: UIView = {
        let v = UIView()
         v.translatesAutoresizingMaskIntoConstraints = false
         return v
    }()
    
    
    lazy var vModemTitle: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .equalSpacing
        v.translatesAutoresizingMaskIntoConstraints = false
         return v
    }()
    
    lazy var vModemInfo:UIView = {
        let v = UIView()
         v.translatesAutoresizingMaskIntoConstraints = false
         return v
    }()
    
    lazy var lbModemName: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var imgModemDropDown: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var imgModem: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var lbModemInfo: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var lbModemDetail: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createUI()
    }
    
    
    func createUI(){
        self.addSubview(vModemContent)
        self.addSubview(imgModem)
        
        vModemContent.addSubview(vModemTitle)
        vModemContent.addSubview(lbModemInfo)
        vModemContent.addSubview(lbModemDetail)
        
        vModemTitle.addArrangedSubview(lbModemName)
        vModemTitle.addArrangedSubview(imgModem)
        
        
        NSLayoutConstraint.activate([
            
            
            self.vModemContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.vModemContent.topAnchor.constraint(equalTo: self.topAnchor,constant: 22),
            self.vModemContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.vModemContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.imgModem.topAnchor.constraint(equalTo: self.topAnchor),
            self.imgModem.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -44.57),
            self.imgModem.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16.24),
            self.imgModem.widthAnchor.constraint(equalToConstant: 76.05),
            
            self.vModemTitle.leadingAnchor.constraint(equalTo: self.vModemContent.leadingAnchor, constant: 16),
            self.vModemTitle.trailingAnchor.constraint(equalTo: self.imgModem.leadingAnchor,constant: -16),
            
            self.lbModemInfo.leadingAnchor.constraint(equalTo: self.vModemContent.leadingAnchor,constant: 16),
            self.lbModemInfo.topAnchor.constraint(equalTo: self.vModemTitle.bottomAnchor, constant: 16),
            
            self.lbModemDetail.topAnchor.constraint(equalTo: self.lbModemInfo.bottomAnchor,constant: 15.64),
            self.lbModemDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
    }
    
    func setupUI(){
        guard let vm = vm else {return}
        
        for item in vm.attributes?.items ?? [] {
            let id = StackModemId(rawValue: item.id ?? "none") ?? .none
            switch(id){
            case .modem_title:
                lbModemName.parseLabel(attr: item)
            case .modem_description:
                lbModemInfo.parseLabel(attr: item)
            case .modem_detail:
                lbModemDetail.parseLabel(attr: item)
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
