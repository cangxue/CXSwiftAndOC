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
    
    var userInfoVC = CXMVCUserInfoViewController()
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
        
    }
    func addUI() {
        let nib = UINib(nibName: "CXMVXUserInfoView", bundle: nil)
        self.userInfoVC.userInfoView = nib.instantiate(withOwner: self, options: nil).first as! CXMVXUserInfoView
        self.userInfoVC.userInfoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.view.addSubview(self.userInfoVC.userInfoView)
        
        let userInfoRect = self.userInfoVC.userInfoView.frame
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
