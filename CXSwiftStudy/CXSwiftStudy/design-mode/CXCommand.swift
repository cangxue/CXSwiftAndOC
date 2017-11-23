//
//  CXCommand.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/23.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

//接收者
class CXBackSys: NSObject {
    func cook(dish: String) {
        return
    }
}
class CXMainFoodSys: CXBackSys {
    override func cook(dish: String) {
        print("MAINFOOD: Cook \(dish)")
    }
}

//命令类
class CXCommand: NSObject {
    var receiver = CXBackSys()
    var dish = ""
    
    func execute() {
        return
    }
}
class CXFoodCommand: CXCommand {
    
    init(receiver: CXBackSys, dish: String) {
        super.init()
        self.receiver = receiver
        self.dish = dish
    }
    override func execute() {
        self.receiver.cook(dish: dish)
    }
}
class CXMainFoodCommand: CXFoodCommand {
    
}

//调用者
class CXWaiterSys: NSObject {
    var commandList: Array = [CXCommand()]
    
    func setOrder(command: CXCommand) {
        self.commandList.append(command)
    }
    
    func notiry() {
        print("WAITER: Notify...")
        for command in self.commandList {
            command.execute()
        }
    }
}
