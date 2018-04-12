//
//  CXTableViewProtocol.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/4/12.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

// 重用表示符
protocol ReusableViewProtocol: class {}

extension ReusableViewProtocol where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// Nib
protocol NibLoadableViewProtocol: class {}

extension NibLoadableViewProtocol where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}

