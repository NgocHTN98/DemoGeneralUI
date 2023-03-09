//
//  HomeVC.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class HomeVC: UIViewController{
    
    @IBOutlet weak var tbvHome: UITableView!
    
    var vm: HomeVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        setupClt()
    }
    
    func setupClt(){
        tbvHome.delegate = self
        tbvHome.dataSource = self

        
    }
    
    func initVM(){
        vm = HomeVM()
        vm.fetchData(vc: self)
        
        vm.baseCallbackReloadData = {
            [weak self] in
                self?.tbvHome.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = vm?.itemAt(index: indexPath.row) else{return UITableViewCell()}

        return UITableViewCell()
    }
}
