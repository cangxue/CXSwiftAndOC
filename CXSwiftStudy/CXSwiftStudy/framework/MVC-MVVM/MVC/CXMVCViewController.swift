//
//  CXMVCViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/4.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.simple_MVC()
    }
    // 复杂MVC框架使用
    func complex_MVC() {
        
    }
    
    // 简单MVC框架使用
    func simple_MVC() {
        let model = CXSimpleMVCModel(name: "Robert", age: 10)
        
        let view = CXSimpleMVCView(frame: CGRect(x: 0, y: 70, width: 300, height: 150))
        self.view.addSubview(view)
        
        let controller = CXSimpleMVCController(model: model, view: view)
        controller.updateView()
        
        let model2 = CXSimpleMVCModel(name: "Baby", age: 8)
        
        let view2 = CXSimpleMVCView(frame: CGRect(x: 0, y: 240, width: 300, height: 150))
        self.view.addSubview(view2)
        
        controller.model = model2
        controller.view = view2
        controller.updateView()
        
        let view3 = CXSimpleMVCView(frame: CGRect(x: 0, y: 410, width: 300, height: 150))
        self.view.addSubview(view3)
        
        controller.view = view3
        
        controller.setModelName(name: "Bob")
        controller.setModelAge(age: 12.0)
        controller.updateView()
    }
}
