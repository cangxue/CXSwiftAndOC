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

        self.factory_design()
    }
    // 工厂模式
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

}
