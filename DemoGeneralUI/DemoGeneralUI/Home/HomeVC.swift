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
        tbvHome.register(UINib(nibName: "StackModemTblCell", bundle: nil), forCellReuseIdentifier: "StackModemTblCell")
        tbvHome.register(UINib(nibName: "ListItemTblCell", bundle: nil), forCellReuseIdentifier: "ListItemTblCell")
    }
    
    func initVM(){
        vm = HomeVM()
        vm.fetchData(vc: self)
        
        vm.baseCallbackReloadData = {
            [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self?.tbvHome.reloadData()
            }
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = vm?.itemAt(index: indexPath.row) else{return UITableViewCell()}
        switch vm.type{
        case .List:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemTblCell") as! ListItemTblCell
            guard let vm = vm.attributes?.items else { return UITableViewCell()}
            cell.vm = vm
            return cell
        case .StackModem:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StackModemTblCell")
            if let cell = cell as? StackModemTblCell{
                cell.vm = vm
                return cell
            }
            return UITableViewCell()
            
        default: return UITableViewCell()
        }
    }
}
