//
//  CXResponsibility.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/23.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

//请假类
class Request: NSObject {
    var requestType = ""
    var requestContent = ""
    var number = 0
    
}

//抽象经理类
class Manager: NSObject {
    var successor: Manager?
    var name = ""
    init(name: String) {
        self.name = name
    }
    
    func setSuccessor(successor: Manager) {
        self.successor = successor
    }
    
    func handleRequest(request: Request) {
        return
    }
}
//直接经理
class LineManager: Manager {
    override func handleRequest(request: Request) {
        if request.requestType == "DayOff" && request.number <= 3 {
            print("\(self.name):\(request.requestContent) Num:\(request.number) Accepted OVER.")
        } else {
            print("\(self.name):\(request.requestContent) Num:\(request.number) Accepted CONTINUE.")
            if self.successor != nil {
                self.successor?.handleRequest(request: request)
            }
        }
    }
}
//部门经理
class DepartmentManager: Manager {
    override func handleRequest(request: Request) {
        if request.requestType == "DayOff" && request.number <= 7 {
            print("\(self.name):\(request.requestContent) Num:\(request.number) Accepted OVER.")
        } else {
            print("\(self.name):\(request.requestContent) Num:\(request.number) Accepted CONTINUE.")
            if self.successor != nil {
                self.successor?.handleRequest(request: request)
            }
        }
    }
}
//总经理
class GeneralManager: Manager {
    override func handleRequest(request: Request) {
        if request.requestType == "DayOff" {
            print("\(self.name):\(request.requestContent) Num:\(request.number) Accepted OVER.")
        }
    }
}
