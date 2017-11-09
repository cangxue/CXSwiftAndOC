//
//  CXFactory.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXFood: NSObject {
    var name = "food"
    var price = 0.00
    var type = "FOOD"
    
    func printFood() {
        print("\(self.name) price is \(self.price)")
    }
}
/************** Burger产品类 *******************/
//抽象产品类
class CXBurger: CXFood {
    override init() {
        super.init()
        self.type = "BURGER"
    }
}
//具体产品类
class CXCheeseBurger: CXBurger {
    override init() {
        super.init()
        self.name = "cheese burger"
        self.price = 12.00
    }
}

/************** Snack产品类 *******************/
//抽象产品类
class CXSnack: CXFood {
    override init() {
        super.init()
        self.type = "SNACK"
    }
}
//具体产品类
class CXChipsSnack: CXSnack {
    override init() {
        super.init()
        self.name = "chip snack"
        self.price = 6.00
    }
}

/************** 工厂类 *******************/
//抽象工厂类
class CXFoodFactory: NSObject {
    func createFood() -> CXFood {
        let food = CXFood()
        return food
    }
    
    func createFoodAndParameters(type: String) -> CXFood {
        let food = CXFood()
        return food
    }
}

//抽象工厂类
class CXBurgerFactory: CXFoodFactory {
    override func createFood() -> CXBurger {
        let burger = CXBurger()
        return burger
    }
    
    override func createFoodAndParameters(type: String) -> CXFood {
        if type == "Cheese" {
            let cheese = CXCheeseBurger.init()
            return cheese
        } else {
            let burger = CXBurger()
            return burger
        }
    }
}

//抽象工厂类
class CXSnackFactory: CXFoodFactory {
    override func createFood() -> CXSnack {
        let snack = CXSnack()
        return snack
    }
    
    override func createFoodAndParameters(type: String) -> CXFood {
        if type == "Chips" {
            let chips = CXChipsSnack.init()
            return chips
        } else {
            let burger = CXBurger()
            return burger
        }
    }
}

//具体工厂类
class CXCheeseBurgerFactory: CXBurgerFactory {
    override func createFood() -> CXCheeseBurger {
        let cheese = CXCheeseBurger.init()
        return cheese
    }
}

//具体工厂类
class CXChipsSnackFactory: CXFoodFactory {
    override func createFood() -> CXChipsSnack {
        let chips = CXChipsSnack.init()
        return chips
    }
}

