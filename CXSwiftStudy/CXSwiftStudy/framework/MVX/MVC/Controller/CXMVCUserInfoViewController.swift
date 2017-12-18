//
//  CXMVCUserInfoViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/18.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCUserInfoViewController: UIViewController {
    @IBOutlet weak var user_icon: UIImageView!
    @IBOutlet weak var user_nameLabel: UILabel!
    @IBOutlet weak var user_blogLabel: UILabel!
    @IBOutlet weak var user_friendLabel: UILabel!
    @IBOutlet weak var user_summaryLabel: UILabel!
    
    var userId = 0
    
    class func viewHeight() -> CGFloat {
        return 200.0
    }
    
    //MARK: - Inferface
    func fetchData() {
        let user = CXMVCUser.init(userId: self.userId)
        self.user_nameLabel.text = user.user_name
        self.user_summaryLabel.text = "个人简介：\(user.user_summary ?? "1")"
        self.user_blogLabel.text = "作品：\(user.user_blogCount ?? 1)"
        self.user_friendLabel.text = "好友：\(user.user_friendCount ?? 1)"
        
    }
    
    //MARK: Action

}
