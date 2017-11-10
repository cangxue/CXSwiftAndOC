//
//  CXFactory.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit


/************** 产品类 *******************/
//抽象产品类
class CXButton: NSObject {
    func display() {
        print("显示button")
    }
}
//具体产品类
class CXRedButton: CXButton {
    override func display() {
        print("显示红色button")
    }
}

//抽象产品类
class CXTextField: NSObject {
    func display() {
        print("显示text field")
    }
}
//具体产品类
class CXRedTextField: CXTextField {
    override func display() {
        print("显示红色text field")
    }
}

/************** 工厂类 *******************/
//简单工厂模式
class CXSimpleFactory: NSObject {
    static func create(className: CXButton) -> CXButton {
        
        let objIns = className
        return objIns
    }
}

//工厂模式
class CXFactory: NSObject {
    func create(className: CXButton) -> CXButton {
        let objIns = className
        return objIns
    }
}

//抽象工厂模式
class CXAbstractFactory: NSObject {
    func createButton() -> CXButton {
        let objIns = CXButton()
        return objIns
    }
    
    func createTextField() -> CXTextField {
        let objIns = CXTextField()
        return objIns
    }
}

//抽象工厂类
class CXAbstractRedFactory: CXAbstractFactory {
    override func createButton() -> CXRedButton {
        let redBtn = CXRedButton()
        return redBtn
    }
    
    override func createTextField() -> CXRedTextField {
        let redField = CXRedTextField()
        return redField
    }
}
