//
//  CXSingleton.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/6.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXSingleton: NSObject {
    
    static let sharedInstance = CXSingleton.init()
    
    var height = 10
    
    // 重载并私有
    private override init() {
        // 初始化一些内容
    }
    
}
