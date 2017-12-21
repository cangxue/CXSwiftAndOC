//
//  CXMVPUserInfoViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/20.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVPUserInfoViewController: NSObject {
    var userId = 0
    
    var userInfoView = CXMVXUserInfoView()
    
    var presenter = CXMVPUserInfoPresenter()
    
    func fetchData() {
        self.presenter.fetchData(userInfoView: self.userInfoView, userId: self.userId) { (user) in
            print(user.user_name)
        }
    }
}
