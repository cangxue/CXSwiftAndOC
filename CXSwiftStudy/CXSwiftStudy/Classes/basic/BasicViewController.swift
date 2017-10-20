//
//  BasicViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/10/17.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    let names = ["111", "222", "333", "444", "555"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let reversedNames = names.sorted(by: backward)
        if reversedNames.count > 0 {
            
        }
        
        let showNames = names.sorted { (s1: String, s2: String) -> Bool in
            return s1 < s2
        }
        if showNames.count > 0 {
            
        }
        
        if backward("aa", "bb") {
            print("aa > bb")
        }
        
    }

    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
}
