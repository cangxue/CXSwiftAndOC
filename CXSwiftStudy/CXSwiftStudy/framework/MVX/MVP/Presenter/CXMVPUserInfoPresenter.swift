//
//  CXMVPUserInfoPresenter.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/20.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVPUserInfoPresenter: NSObject {
    
    func fetchData(userInfoView: CXMVXUserInfoView, userId: Int, completion: @escaping (_ user: CXMVXUser) -> (Void)) {
        let user = CXMVXUser()
        user.user_name = "user\(userId)"
        user.user_summary = "userSummary\(userId)"
        user.user_blogCount = userId + 18
        user.user_friendCount = userId + 22
        
        userInfoView.user_nameLabel.text = user.user_name
        userInfoView.user_summaryLabel.text = "个人简介：\(user.user_summary)"
        userInfoView.user_blogLabel.text = "作品：\(user.user_blogCount)"
        userInfoView.user_friendLabel.text = "好友：\(user.user_friendCount)"
        
        completion(user)
    }

}
