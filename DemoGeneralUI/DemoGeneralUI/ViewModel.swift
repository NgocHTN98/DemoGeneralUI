//
//  ViewModel.swift
//  DemoGeneralUI
//
//  Created by NgocHTN6 on 07/03/2023.
//

import Foundation
class ViewModel {
    var service = Service()
    
    func getData() {
        self.service.request()
    }
}
