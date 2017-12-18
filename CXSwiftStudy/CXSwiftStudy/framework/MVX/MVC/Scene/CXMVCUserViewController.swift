//
//  CXMVCUserViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCUserViewController: CXBaseViewController {
    
    var userId = 0
    
    let userInfoVC = CXMVCUserInfoViewController()
    let blogVC = CXMVCBlogViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configuration()

        self.addUI()
        
        self.fetchData()
    }

    func configuration() {
        self.title = "MVC"
        self.userId = 20
        
        self.userInfoVC.userId = self.userId
        
        self.addChildViewController(self.userInfoVC)
    }
    func addUI() {
        let userInfoViewHeight = CXMVCUserInfoViewController.viewHeight()
        self.userInfoVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: userInfoViewHeight)
        self.view.addSubview(self.userInfoVC.view)
        
        let userInfoRect = userInfoVC.view.frame
        self.blogVC.tableView?.frame = CGRect(x: 0, y: userInfoRect.maxY, width: userInfoRect.width, height: self.view.frame.height - userInfoRect.height - 64)
        self.view.addSubview(self.blogVC.tableView!)
    }
    
    func fetchData() {
        self.userInfoVC.fetchData()
        
        self.blogVC.fetchDataWithCompletionHandler(userId: self.userId) { (userId, success) in
            if success {
                print("获取成功\(userId)")
            }
        }
    }

}
