//
//  CXRxSwiftValidateModel.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// Model
struct CXRxSwiftValidateModel: ValidatedModelType {
    
    static let sharedInstance = CXRxSwiftValidateModel()
    
    func validatedUsername(_ username: String) -> String {
        return username.uppercased()
    }
    
    func validatedPassword(_ password: String) -> String {
        return password.lowercased()
    }
    
    func combine(_ username: String, _ password: String) -> String {
        return username + password
    }
    
    func login(_ username: String, _ password: String) -> LoginResult {
        guard username.count > 3 else {
            return .invalidatedUsername
        }
        guard password.count > 3 else {
            return .invalidatedPassword
        }
        
        return (8...12).contains(username.count + password.count) ? .success: .failure
    }
}

extension LoginResult {
    
    var description: String {
        switch self {
        case .invalidatedUsername:
            return "无效的用户名"
        case .invalidatedPassword:
            return "无效的密码"
        case .success:
            return "登录成功"
        case .failure:
            return "登录失败"
            
        }
    }
}
