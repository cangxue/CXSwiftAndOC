//
//  ViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 17/4/12.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func collectionBtnClick(_ sender: Any) {
        let vc = CollectionViewController()
        vc.title = "Collection"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func blockBtnClick(_ sender: Any) {
        let vc = CXBlockViewController()
        vc.title = "Block"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func locationBtnClick(_ sender: Any) {
        let vc = CXLocationViewController()
        vc.title = "Location"
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

