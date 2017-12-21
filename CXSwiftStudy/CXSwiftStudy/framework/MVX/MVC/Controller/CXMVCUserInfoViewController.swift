//
//  CXMVCUserInfoViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/20.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCUserInfoViewController: NSObject {
    var userId = 0

    var userInfoView = CXMVXUserInfoView()
    
    
    func fetchData() {
        let user = CXMVXUser()
        user.user_name = "user\(self.userId)"
        user.user_summary = "userSummary\(self.userId)"
        user.user_blogCount = self.userId + 8
        user.user_friendCount = self.userId + 12
        
        self.infoViewUpdate(user: user)
        
    }
    
    func infoViewUpdate(user: CXMVXUser) {
        self.userInfoView.user_nameLabel.text = user.user_name
        self.userInfoView.user_summaryLabel.text = "个人简介：\(user.user_summary)"
        self.userInfoView.user_blogLabel.text = "作品：\(user.user_blogCount)"
        self.userInfoView.user_friendLabel.text = "好友：\(user.user_friendCount)"
    }
}
