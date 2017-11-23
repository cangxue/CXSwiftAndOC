//
//  CXBridge.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/22.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

//接口类
class Shape: NSObject {
    var name = "shape"
    var param: Array = [String]()
    init(param: [String]) {
        return
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getParam() -> (String, Array<Any>) {
        return (self.name, self.param)
    }
}

class Pen: NSObject {
    var shape: Shape?
    var type = ""
    init(shape: Shape) {
        self.shape = shape
    }
    
    func draw() {
        return
    }
}

// 实现类
class Rectangle: Shape {
    init(long: String, width: String) {
        super.init(param: [])
        self.name = "Rectangle"
        self.param = ["long: \(long)", "width: \(width)"]
        
        print("Create a rectangle: \(self.param)")
    }
}
class Circle: Shape {
    init(radius: String) {
        super.init(param: [])
        self.name = "Circle"
        self.param = ["Radius: \(radius)"]
        
        print("Create a circle: \(self.param)")
    }
}

//抽象类
class NormalPen: Pen {
    init(n_shape: Shape) {
        super.init(shape: n_shape)
        self.type = "Normal Line"
    }
    
    override func draw() {
        
        print("DRAWING: \(self.type):\(self.shape?.getName() ?? "shape") ---- PARAMS: \(self.shape?.getParam() ?? ("circle", ["long: 20cm"]))")
    }
}
class BrushPen: Pen {
    init(b_shape: Shape) {
        super.init(shape: b_shape)
        self.type = "Brush Line"
    }
    override func draw() {
        print("DRAWING: \(self.type):\(self.shape?.getName() ?? "shape") ---- PARAMS: \(self.shape?.getParam() ?? ("circle", ["long: 20m"]))")
    }
}


