//
//  ViewController.swift
//  DemoGeneralUI
//
//  Created by NgocHTN6 on 06/03/2023.
//

import UIKit

class ViewController: UIViewController {

    var vm: ViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewModel()
    }

    
    func initViewModel() {
        self.vm = ViewModel()
        self.vm?.getData()
    }

}

