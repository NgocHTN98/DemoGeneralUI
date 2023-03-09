//
//  BaseViewModel.swift
//  Hi FPT
//
//  Created by Trinh Quang Hiep on 14/07/2022.
//

import Foundation
class BaseViewModel<T>:NSObject{
    var items : [T] = [T]()
    var baseCallbackReloadData :(()->())?
    deinit {
        debugPrint("---------------\(String(describing: type(of: self))) disposed-------------")
    }
    func setDataItems(data : [T]){
        self.items = data
        self.baseCallbackReloadData?()
    }
    func numberOfItem() -> Int{
        return items.count
    }
    func itemAt(index: Int)->T?{
        guard index <= numberOfItem() - 1 else {return nil}
        return items[index]
    }
}
