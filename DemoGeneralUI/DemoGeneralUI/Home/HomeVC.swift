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
    
    var vm: HomeVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        setupClt()
    }
    
    func setupClt(){
        clvHome.register(UINib(nibName: "StackModemCltCell", bundle: nil), forCellWithReuseIdentifier: "StackModemCltCell")
        clvHome.register(UINib(nibName: "StackStatusCltCell", bundle: nil), forCellWithReuseIdentifier: "StackStatusCltCell")
        clvHome.register(UINib(nibName: "StackServiceCltCell", bundle: nil), forCellWithReuseIdentifier: "StackServiceCltCell")
        
    }
    
    func initVM(){
        vm = HomeVM()
        vm.fetchData(vc: self)
    }
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.homeData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = vm.itemAt(index: section) else{
            return 0
        }
        
        switch vm.type{
        case .List:
            return vm.attributes?.items.count ?? 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let vm = vm.itemAt(index: indexPath.row) else{
            return UICollectionViewCell()
        }
        
        switch(vm.type){
        case .StackModem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackModemCltCell", for: indexPath) as? StackModemCltCell else {return UICollectionViewCell()}
            
            return cell
            
        case .StackConnect:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackStatusCltCell", for: indexPath) as? StackStatusCltCell else {return UICollectionViewCell()}
            
            return cell
        case .StackInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackInfoCltCell", for: indexPath) as? StackInfoCltCell else {return UICollectionViewCell()}
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
