//
//  ListItemTblCell.swift
//  DemoGeneralUI
//
//  Created by NhungNTT47 on 09/03/2023.
//

import UIKit

class ListItemTblCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var vm: [AttributeRes] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "StackStatusCltCell", bundle: nil), forCellWithReuseIdentifier: "StackStatusCltCell")
        collectionView.register(UINib(nibName: "StackInfoCltCell", bundle: nil), forCellWithReuseIdentifier: "StackInfoCltCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ListItemTblCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = vm[indexPath.row]
        switch vm.type{
        case .StackInfo:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackInfoCltCell", for: indexPath) as? StackInfoCltCell {
                cell.vm = vm
                return cell
            }
            return UICollectionViewCell()
        case .StackConnect:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StackStatusCltCell", for: indexPath) as? StackStatusCltCell {
                cell.vm = vm
                return cell
            }
            return UICollectionViewCell()
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = UIScreen.main.bounds.width
        guard let ratioParent = vm[indexPath.row].width_ratio_parent_view else { return .zero }
        let widthCell = widthScreen/CGFloat(ratioParent)
        guard let ratioHeight = vm[indexPath.row].width_height_ratio else { return .zero }
        let heightCell = widthCell * CGFloat(ratioHeight)
        return CGSize(width: widthCell, height: heightCell)
    }
}
