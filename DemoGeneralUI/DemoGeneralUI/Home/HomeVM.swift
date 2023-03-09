//
//  HomeVM.swift
//  DemoGeneralUI
//
//  Created by Nghia Dao on 3/7/23.
//

import Foundation
import UIKit

class HomeVM:BaseViewModel<AttributeRes>{

    var homeData: [AttributeRes]?
    
    func fetchData(vc: UIViewController){
        Service().request(callBackData: {
           [weak self] rp in
            
            self?.homeData = rp.group
            
            self?.setDataItems(data: self?.homeData ?? [])
            
        })
    }
}
