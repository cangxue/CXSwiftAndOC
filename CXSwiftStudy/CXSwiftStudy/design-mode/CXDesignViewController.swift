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
        self.facade_design()
        
        let person = ProxyPerson()
        person.delegate = self
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
