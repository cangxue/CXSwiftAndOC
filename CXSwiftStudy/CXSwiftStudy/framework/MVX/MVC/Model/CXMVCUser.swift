//
//  CXMVCUser.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCUser: NSObject {
    var user_name: String?
    var user_summary: String?
    var user_icon: String?
    var user_userId: NSInteger?
    var user_blogCount: NSInteger?
    var user_friendCount: NSInteger?
    
    init(userId: NSInteger) {
        self.user_name = "user\(userId)"
        self.user_summary = "userSummary\(userId)"
        self.user_blogCount = userId + 8
        self.user_friendCount = userId + 12
    }
}
