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
        
        self.state_design()
    }
    //状态模式
    func state_design() {
        let ctx = Context()
        ctx.lift_state = StopState()
        ctx.open()
        ctx.run()
        ctx.close()
        ctx.run()
        ctx.stop()
        
    }
    //备忘录模式
    func memento_design() {
        let game_chrctr = FightCharactor()
        game_chrctr.initState(vitality: 100, attack: 79, defense: 40)
        game_chrctr.displayState()
        
        let memento = game_chrctr.saveState()
        
        game_chrctr.fight()
        game_chrctr.displayState()
        
        game_chrctr.recoverState(memento: memento)
        game_chrctr.displayState()
    }
    //解释器模式
    func interpreter_design() {
        let context = PlayContext()
        context.play_text = "C53231323 Em43231323 F43231323 G63231323"
        
        let guitar = NormGuitar()
        guitar.interpret(context: context)
    }
    //观察者模式
    func observer_design() {
        let alarm = CXAlarmSensor()
        let sprinker = CXWaterSprinker()
        let dialer = CXEmergencyDialer()
        
        let smoke_sensor = CXSmokeSensor()
        smoke_sensor.addObserver(observer: alarm)
        smoke_sensor.addObserver(observer: sprinker)
        smoke_sensor.addObserver(observer: dialer)
        
        if smoke_sensor.isFire() {
            smoke_sensor.action = "On Fire!"
            smoke_sensor.notifyAll()
        }
        
    }
    //访问者模式
    func visitor_design() {
        let yinqiao_pill = Coldrex(name: "Yinqiao Pill", price: 2.0)
        let penicillin = Antibiotic(name: "Penicillin", price: 3.0)
        
        let doctor_prsrp = Prescription()
        doctor_prsrp.addMedicine(medicine: yinqiao_pill)
        doctor_prsrp.addMedicine(medicine: penicillin)
        
        let charger = Charger() //划价员
        charger.name = "Doctor Strange"
        let pharger = Pharmacy() //管理员
        pharger.name = "Doctor Wei"
        
        doctor_prsrp.visit(visitor: charger)
        doctor_prsrp.visit(visitor: pharger)
        
        
    }
    //迭代器模式
    func iterator_design() {
        //MAKE: - Usage
        //创建小说迭代器并添加些小说
        let novella1 = Novella(name: "frist")
        let novella2 = Novella(name: "second")
        let novella3 = Novella(name: "third")
        let novella4 = Novella(name: "four")
        
        let greatNovellas = Novellas(novellas: [novella1, novella2, novella3, novella4])
        
        //遍历取出小说阅读
        for novella in greatNovellas {
            print("I 've read: \(novella.name)")
        }
    }
    //模版模式
    func template_design() {
        let web_a_query_dev = WebAStockQueryDevice()
        
        if web_a_query_dev.operateQuery(usr: "myStockA", pwd: "myPwdA", code: "123456") {
            print("SUCCESS")
        } else {
            print("FAILED")
        }
        
    }
    //中介者模式
    func mediator_design() {
        let mobile_mediatro = StockMediator()
        
        let mobile_purchase = PurchaseColleague(mediator: mobile_mediatro)
        let mobile_warehouse = WarehouseColleague(mediator: mobile_mediatro)
        let mobile_sale = SaleColleague(mediator: mobile_mediatro)
        
        mobile_mediatro.purchase = mobile_purchase
        mobile_mediatro.warehouse = mobile_warehouse
        mobile_mediatro.sales = mobile_sale
        
        mobile_warehouse.threshold = 200
        mobile_purchase.buyStuff(num: 300)
        mobile_sale.sellStuff(num: 120)
        
    }
    //命令模式
    func command_design() {
        //接收者
        let main_food_sys = CXMainFoodSys()
        
        //命令者
        let cmd1 = CXMainFoodCommand(receiver: main_food_sys, dish: "西红柿鸡蛋")
        let cmd2 = CXMainFoodCommand(receiver: main_food_sys, dish: "酸辣土豆丝")
        
        //调用者
        let waiter_sys = CXWaiterSys()
        waiter_sys.setOrder(command: cmd1)
        waiter_sys.setOrder(command: cmd2)
        
        waiter_sys.notiry()
        
        
    }
    //责任链模式
    func resposibility_design() {
        let line_manager = LineManager(name: "Line Manager")
        let department_manager = DepartmentManager(name: "Department Manager")
        let general_manager = GeneralManager(name: "General Manager")
        
        line_manager.setSuccessor(successor: department_manager)
        department_manager.setSuccessor(successor: general_manager)
        
        let req = Request()
        req.requestType = "DayOff"
        req.requestContent = "Ask 1 day off"
        req.number = 1
        line_manager.handleRequest(request: req)
        print("=================")
        req.requestContent = "Ask 5 day off"
        req.number = 5
        line_manager.handleRequest(request: req)
        print("=================")
        req.requestContent = "Ask 10 day off"
        req.number = 10
        line_manager.handleRequest(request: req)
        
    }
    //策略模式
    func strategy_design() {
        let customer_x = CXCustomer()
        customer_x.customer_name = "CUSTOMER_X"
        customer_x.info = "Welcome to our new party"
        customer_x.email = "customer@xemail.com"
        customer_x.phone = "123456"
        
        let email_sender = EmailSender()
        email_sender.setCode(code: customer_x.email)
        customer_x.setBrdWay(send_way: email_sender)
        customer_x.send()
        
        let text_sender = TextSender()
        text_sender.setCode(code: customer_x.phone)
        customer_x.setBrdWay(send_way: text_sender)
        customer_x.send()
    }
    //桥梁模式
    func bridge_design() {
        let normal_pen = NormalPen(n_shape: Rectangle(long: "20cm", width: "10cm"))
        let brush_pen = BrushPen(b_shape: Circle(radius: "15cm"))
        normal_pen.draw()
        brush_pen.draw()
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
