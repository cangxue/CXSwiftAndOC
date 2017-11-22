//
//  CXDesignViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXDesignViewController: CXBaseViewController, buyTicketProtocol {
    func buyTicket() {
        print("自己买票")
    }
    
    func showTicketNumber() {
        print("222222")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flyweight_design()
    }
    //享元模式
    func flyweight_design() {
        let coffee_factory = CoffeeFactory()
        
        let customer_1 = Customer(name: "A Client", coffee_factory: coffee_factory)
        let customer_2 = Customer(name: "B Client", coffee_factory: coffee_factory)
        let customer_3 = Customer(name: "C Client", coffee_factory: coffee_factory)
        
        let c1_capp = customer_1.order(coffee_name: "cappuccino")
        c1_capp.show()
        let c2_mocha = customer_2.order(coffee_name: "mocha")
        c2_mocha.show()
        let c3_capp = customer_3.order(coffee_name: "cappuccino")
        c3_capp.show()
        
        print("Num of Coffee Instance: \(coffee_factory.getCoffeeCount())")
        
        
    }
    //组合模式
    func composite_design() {
        let root = ConcreateCompany(name: "HeadQuarter")
        root.add(company: HRDepartment(name: "HQ HR"))
        root.add(company: FinanceDepartment(name: "HQ Finance"))
        root.add(company: RdDepartment(name: "HQ R&D"))
        
        let comp = ConcreateCompany(name: "East Branch")
        comp.add(company: HRDepartment(name: "East.Br HR"))
        comp.add(company: FinanceDepartment(name: "East.Br Finance"))
        comp.add(company: RdDepartment(name: "East.Br R&D"))
        root.add(company: comp)
        
        let comp1 = ConcreateCompany(name: "Northast Branch")
        comp1.add(company: HRDepartment(name: "Northeast.Br HR"))
        comp1.add(company: FinanceDepartment(name: "Northeast.Br Finance"))
        comp1.add(company: RdDepartment(name: "Northeast.Br R&D"))
        comp.add(company: comp1)
        
        
        let comp2 = ConcreateCompany(name: "Southeast Branch")
        comp2.add(company: HRDepartment(name: "Southeast.Br HR"))
        comp2.add(company: FinanceDepartment(name: "Southeast.Br Finance"))
        comp2.add(company: RdDepartment(name: "Southeast.Br R&D"))
        comp.add(company: comp2)
        
        root.display(depth: 1)
        
        root.listDuty()
        
    }
    //门面模式
    func facade_design() {
        let facde = CXFacade()
        facde.runAll()
    }
    //适配器模式
    func adapter_design() {
        let media_adapter = MediaAdapter()
        media_adapter.play(fileName: "alone.mp4")
        
    }
    //装饰器模式
    func derocator_design() {
        let hero = BlindMonk()
        hero.learnSkills()
        
        let skill_decorator = SkillsDecorator()
        skill_decorator.hero = hero
        skill_decorator.learnSkills()
        
        let skill_q_decorator = Skill_QDecorator()
        skill_q_decorator.hero = hero
        skill_q_decorator.skillName = "天音波/回音击"
        skill_q_decorator.learnSkills()
        
    }
    //代理模式
    func proxy_design() {
        //买票的人
        let person = ProxyPerson()
        //会买票的黄牛
        let tout = ProxyTout()
        
        //调用代理方法
        person.delegate = self
        person.delegate?.buyTicket()
        person.delegate?.showTicketNumber!()
        
        person.delegate = tout //人的代理设置为黄牛
        person.delegate?.buyTicket() //黄牛买了一张火车票
        person.delegate?.showTicketNumber!()
        
        
        
    }
    //原型模式
    func prototype_design() {
        //Original
        let dog_layer = CXSimpleLayer(background: [0, 0, 0, 0], content: "dog");
        dog_layer.content = "Dog"
        dog_layer.background = [0, 0, 255, 0]
        print("Original Background: \(dog_layer.background) \nOriginal Painting: \(dog_layer.content)")
        print("====================")
        //copy
        let shall_copy_layer = dog_layer
        shall_copy_layer.background = [0, 0, 111, 0]
        print("Original Background: \(dog_layer.background) \nOriginal Painting: \(dog_layer.content)")
        print("Shall Background: \(shall_copy_layer.background) \nOriginal Painting: \(shall_copy_layer.content)")
        print("====================")
        //deep copy
        let deep_copy_layer = dog_layer.copy() as! (CXSimpleLayer)
        deep_copy_layer.background = [0, 0, 222, 0]
        print("Original Background: \(dog_layer.background) \nOriginal Painting: \(dog_layer.content)")
        print("Shall Background: \(shall_copy_layer.background) \nOriginal Painting: \(shall_copy_layer.content)")
        print("Deep Background: \(deep_copy_layer.background) \nOriginal Painting: \(deep_copy_layer.content)")
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
