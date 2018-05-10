//
//  CXTabBarViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/11.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置中心按钮
        setupCustomTabbar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 设置自定义中心按钮
    func setupCustomTabbar() {
        let tabbar = CXCenterTabBar()
        tabbar.itemCount = 2
        self.setValue(tabbar, forKeyPath: "tabBar")
        tabbar.centerButton.addTarget(self, action: #selector(centerButtonClick), for: .touchUpInside)
        
    }
    
    @objc func centerButtonClick() {
        print("点击了")
    }

}
