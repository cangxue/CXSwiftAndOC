//
//  CXBuilder.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/13.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class Burger: NSObject {
    var name: String?
    var price: Double?
}
class cheeseBurger: Burger {
    override init() {
        super.init()
        self.name = "cheese burger"
        self.price = 10.0
    }
}
class spicyChickenBurger: Burger {
    override init() {
        super.init()
        self.name = "spicy chicken burger"
        self.price = 15.0
    }
}

class Snack: NSObject {
    var name: String?
    var price: Double?
    var type = "Snack"
}
class chips: Snack {
    override init() {
        super.init()
        self.name = "chips"
        self.price = 6.0
    }
}
class chickenWings: Snack {
    override init() {
        super.init()
        self.name = "chicken wings"
        self.price = 12.0
    }
}

class Beverage: NSObject {
    var name: String?
    var price: Double?
    var type = "BEVERAGE"
}
class coke: Beverage {
    override init() {
        super.init()
        self.name = "coke"
        self.price = 4.0
    }
}
class milk: Beverage {
    override init() {
        super.init()
        self.name = "milk"
        self.price = 5.0
    }
}

class CXBuilder: NSObject {
    var bBurger: Burger?
    var bSnack: Snack?
    var bBeverage: Beverage?
    
    func addBurger(xBurger: Burger) {
        self.bBurger = xBurger
    }
    func addSnack(xSnack: Snack) {
        self.bSnack = xSnack
    }
    func addBeverage(xBeverage: Beverage) {
        self.bBeverage = xBeverage
    }
    
    func build() -> Order {
        return Order(orderBuilder: self)
    }
}

class Order: NSObject {
    var burger: Burger?
    var snack: Snack?
    var beverage: Beverage?
    init(orderBuilder: CXBuilder) {
        self.burger = orderBuilder.bBurger
        self.snack = orderBuilder.bSnack
        self.beverage = orderBuilder.bBeverage
    }
    
    func show() {
        print("订单信息是：")
        print("Burger: \(burger?.name ?? "burger")")
        print("Snack: \(snack?.name ?? "snack")")
        print("Beverage: \(beverage?.name ?? "beverage")")
    }
}

class OrderDirector: NSObject {
    var order_builder: CXBuilder?
    init(orderBuilder: CXBuilder) {
        self.order_builder = orderBuilder
    }
    
    func createOrder(burger: Burger, snack: Snack, beverage: Beverage) -> Order {
        self.order_builder?.addBurger(xBurger: burger)
        self.order_builder?.addSnack(xSnack: snack)
        self.order_builder?.addBeverage(xBeverage: beverage)
        return (self.order_builder?.build())!
    }
}

