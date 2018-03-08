//
//  CXRxSwiftProtocols.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

// MARK: -- Enum --
enum LoginResult {
    case invalidatedUsername
    case invalidatedPassword
    case success
    case failure
}

// MARK: -- Protocol --
protocol ValidatedModelType {
    func validatedUsername(_ username: String) -> String
    func validatedPassword(_ password: String) -> String
    func combine(_ username: String, _ password: String) -> String
    func login(_ username: String, _ password: String) -> LoginResult
}
