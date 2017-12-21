//
//  CXMVXViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/4.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVXViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.complex_MVX()

    }
    // 复杂MVC框架使用
    func complex_MVX() {
        let viewheight = self.view.frame.height - 64
        let MVCBtn = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: viewheight / 3))
        MVCBtn.setTitle("MVC", for: .normal)
        MVCBtn.backgroundColor = UIColor.blue
        MVCBtn.addTarget(self, action: #selector(MVCBtnClick), for: .touchUpInside)
        self.view.addSubview(MVCBtn)
        
        let MVPBtn = UIButton(frame: CGRect(x: 0, y: viewheight / 3, width: self.view.frame.width, height: viewheight / 3))
        MVPBtn.setTitle("MVP", for: .normal)
        MVPBtn.backgroundColor = UIColor.orange
        MVPBtn.addTarget(self, action: #selector(MVPBtnClick), for: .touchUpInside)
        self.view.addSubview(MVPBtn)
        
        let MVVMBtn = UIButton(frame: CGRect(x: 0, y: 2*viewheight / 3, width: self.view.frame.width, height: viewheight / 3))
        MVVMBtn.setTitle("MVVM", for: .normal)
        MVVMBtn.backgroundColor = UIColor.red
        MVVMBtn.addTarget(self, action: #selector(MVVMBtnClick), for: .touchUpInside)
        self.view.addSubview(MVVMBtn)
        
    }
    func MVCBtnClick() {
        self.navigationController?.pushViewController(CXMVCUserViewController(), animated: true)
    }
    func MVPBtnClick() {
        self.navigationController?.pushViewController(CXMVPUserViewController(), animated: true)
    }
    func MVVMBtnClick() {
        self.navigationController?.pushViewController(CXMVCUserViewController(), animated: true)
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
