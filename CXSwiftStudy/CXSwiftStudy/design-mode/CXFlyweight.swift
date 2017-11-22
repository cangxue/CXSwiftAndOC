//
//  CXFlyweight.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/22.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class Coffee: NSObject {
    var name: String = ""
    var price = 0
    init(name: String) {
        self.name = name
        self.price = name.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
    }
    
    func show() {
        print("Coffee Name: \(self.name) Price: \(self.price)")
    }
    
}

class CoffeeFactory: NSObject {
    var coffee_dict = Dictionary<String, Coffee>()
    
    func getCoffee(name: String) -> Coffee {
        if self.coffee_dict.keys.contains(name) == false {
            self.coffee_dict[name] = Coffee(name: name)
        }
        return self.coffee_dict[name]!
    }
    
    func getCoffeeCount() -> Int {
        return self.coffee_dict.count
    }
}

class Customer: NSObject {
    var coffee_factory = CoffeeFactory()
    var name = ""
    init(name: String, coffee_factory: CoffeeFactory) {
        self.name = name;
        self.coffee_factory = coffee_factory
    }
    
    func order(coffee_name: String) -> Coffee {
        print("\(self.name) ordered a cup of coffee: \(coffee_name)")
        return self.coffee_factory.getCoffee(name: coffee_name)
    }
}








