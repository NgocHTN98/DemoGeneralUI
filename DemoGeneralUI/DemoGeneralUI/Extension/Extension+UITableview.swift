//
//  Extension+UITableview.swift
//  Hi FPT
//
//  Created by Jenny on 23/07/2021.
//

import UIKit

extension UITableView
{
    func setIdentifier(_ value : String)
    {
        self.register(UINib.init(nibName: value, bundle: Bundle.main), forCellReuseIdentifier: value)
    }
    
    func scrollToBottom(isAnimated:Bool = true){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
