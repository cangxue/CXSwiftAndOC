//
//  CXDesignViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXDesignViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.builder_design()
    }
    //创建者模式
    func builder_design() {
        //方法一
        let order_builder = CXBuilder()
        order_builder.addBurger(xBurger: cheeseBurger())
        order_builder.addSnack(xSnack: chips())
        order_builder.addBeverage(xBeverage: coke())
        let order_1 = order_builder.build()
        order_1.show()
        
        //方法二
        let builderDirector = OrderDirector(orderBuilder: order_builder)
        let order_2 = builderDirector.createOrder(burger: spicyChickenBurger(), snack: chickenWings(), beverage: milk())
        order_2.show()
        
    }
    //工厂模式
    func factory_design() {
        
        //简单工厂模式
        print("============= 简单工厂模式 =================")
        let simpleFactory = CXSimpleFactory.create(className: CXRedButton())
        simpleFactory.display()
        
        
        //工厂模式
        print("============= 工厂模式 =================")
        let factory = CXFactory()
        let redBtn = factory.create(className: CXRedButton());
        redBtn.display()
        
        //抽象工厂模式
        print("============= 抽象工厂模式 =================")
        let abstractFactory = CXAbstractRedFactory()
        let absBtn = abstractFactory.createButton()
        absBtn.display()
        let absField = abstractFactory.createTextField()
        absField.display()
    }
    //单例模式
    func singleton_design() {
        let singleton = CXSingleton.sharedInstance
        singleton.height = 20
        print(singleton.height)
        CXSingleton.sharedInstance.height = 30
        print(singleton.height)
        
    }

}
