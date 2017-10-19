//
//  BasicViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/10/17.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        var reversedNames = names.sorted(by: backward)
        if reversedNames.count > 0 {
            
        }
        
    }

    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    
}
