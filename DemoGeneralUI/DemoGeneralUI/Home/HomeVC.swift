//
//  HomeVC.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class HomeVC: UIViewController{
    
    @IBOutlet weak var clvHome: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
    }
    
    func setupClt(){
//        clvHome.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        
    }
    
    func initVM(){
        
    }
}
