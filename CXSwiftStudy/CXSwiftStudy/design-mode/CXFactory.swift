//
//  CXFactory.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXFactory: NSObject {

}

//抽象产品
class CXBurger: NSObject {
    var name = ""
    var price = 0.00
}

//具体产品
class CXCheeseBurger: CXBurger {
    
}

//抽象工厂
class CXBurgerFactory: NSObject {
    func printCheeseBurgerNameAndPrice() -> CXCheeseBurger {
        let cheeseBurger = CXCheeseBurger()
        return cheeseBurger
    }
}

//具体工厂
class CXBigCheeseBurgerFactory: CXBurgerFactory {
    override func printCheeseBurgerNameAndPrice() -> CXCheeseBurger {
        let cheeseBurger = CXCheeseBurger()
        cheeseBurger.name = "big cheese burger"
        cheeseBurger.price = 12.00
        return cheeseBurger
    }
}

//具体工厂
class CXSmallCheeseBurgerFactory: CXBurgerFactory {
    override func printCheeseBurgerNameAndPrice() -> CXCheeseBurger {
        let cheeseBurger = CXCheeseBurger()
        cheeseBurger.name = "small cheese burger"
        cheeseBurger.price = 6.00
        return cheeseBurger
    }
}

