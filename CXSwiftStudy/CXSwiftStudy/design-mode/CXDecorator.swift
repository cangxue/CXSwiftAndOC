//
//  CXDecorator.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/19.
//  Copyright © 2017年 CX. All rights reserved.
//  装饰器模式

import UIKit

class Drink: NSObject {
    var name: String?
    var price: Double?
    var type = "DRINK"
}
class drink_coke: Drink {
    override init() {
        super.init()
        self.name = "coke"
        self.price = 4.0
    }
}
class drink_milk: Drink {
    override init() {
        super.init()
        self.name = "milk"
        self.price = 5.0
    }
}


class Decorator: NSObject {
    
    func getDrinkName(drink: Drink) -> String {
        let str = "one"
        return str
    }
    
    func getDrinkPrice(drink: Drink) -> Double {
        let dou = 3.0
        return dou
        
    }
}

class IceDecerator: Decorator {

    
    override func getDrinkName(drink: Drink) -> String{
        return drink.name! + "+ice"
    }
    
    override func getDrinkPrice(drink: Drink) -> Double {
        return drink.price! + 0.5
    }
}



