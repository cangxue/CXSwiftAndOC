//
//  CXMVCSimpleController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/4.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit
class CXSimpleMVCModel: NSObject {
    var name = "name"
    var age = 0.0
    
    init(name: String, age: Double) {
        self.name = name
        self.age = age
    }
}

class CXSimpleMVCView: UIView {
    var name_label = UILabel()
    var age_label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.gray
        
        self.name_label.frame = CGRect(x: 20, y: 20, width: 200, height: 44)
        self.name_label.textColor = UIColor.red
        self.addSubview(self.name_label)
        
        self.age_label.frame = CGRect(x: 20, y: 84, width: 100, height: 44)
        self.age_label.textColor = UIColor.red
        self.addSubview(self.age_label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNameLabelText(text: String) {
        self.name_label.text = "name: \(text)"
    }
    
    func setAgeLabelText(text: Double) {
        self.age_label.text = "age: \(text)"
    }
}

class CXSimpleMVCController: NSObject {
    var model: CXSimpleMVCModel?
    var view: CXSimpleMVCView?
    init(model: CXSimpleMVCModel, view: CXSimpleMVCView) {
        self.model = model
        self.view = view
    }
    
    func setModelName(name: String) {
        self.model?.name = name
    }
    
    func setModelAge(age: Double) {
        self.model?.age = age
    }
    
    func updateView() {
        self.view?.setNameLabelText(text: (self.model?.name)!)
        self.view?.setAgeLabelText(text: (self.model?.age)!)
    }
}
