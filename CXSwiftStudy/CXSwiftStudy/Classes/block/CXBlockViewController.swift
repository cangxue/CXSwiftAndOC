//
//  CXBlockViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/8/3.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit




class CXBlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        
        self.declare { (json, isSuccess) in
            if isSuccess {
                print("success")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func declare(completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) ->Void) {
        completion(nil, true)
        
    }

}
