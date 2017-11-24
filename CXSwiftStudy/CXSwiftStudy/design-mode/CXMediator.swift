//
//  CXMediator.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/24.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

//子系统
class Colleague: NSObject {
    var mediator: AbstractMediator?
    init(mediator: StockMediator) {
        self.mediator = mediator
    }
}
// 采购
class PurchaseColleague: Colleague {
    func buyStuff(num: Int) {
        print("PURCHASE: Bought \(num)")
        self.mediator?.execute(content: "buy", num: num)
    }
    func getNotice(content: String) {
        print("PURCHASE: Get Notice -- \(content)")
    }
}
//仓库
class WarehouseColleague: Colleague {
    var total = 0
    var threshold = 100
    func isEnough() {
        if self.total < self.threshold {
            print("WAREHOUSE: Warning...Stock is low...")
            self.mediator?.execute(content: "warning", num: self.total)
        } else {
            print("WAREHOUSE: Stock is enough")
        }
    }
    
    func inc(num: Int) {
        self.total += num
        print("WAREHOUSE: Increase \(num)")
        self.mediator?.execute(content: "increase", num: num)
        self.isEnough()
    }
    func dec(num: Int) {
        if num > self.total {
            print("WAREHOUSE: Error...Stock is not enough")
        } else {
            self.total -= num
            print("WAREHOUSE: Decrease \(num)")
            self.mediator?.execute(content: "decrease", num: num)
            self.isEnough()
        }
    }
}
//销售
class SaleColleague: Colleague {
    func sellStuff(num: Int) {
        print("SALE: Sell \(num)")
        self.mediator?.execute(content: "sell", num: num)
    }
    func getNotice(content: String) {
        print("SALE: Get Notice -- \(content)")
    }
}

//中介者
class AbstractMediator: NSObject {
    var purchase: PurchaseColleague?
    var warehouse: WarehouseColleague?
    var sales: SaleColleague?
    func execute(content: String, num: Int) {
        return
    }
    
}
class StockMediator: AbstractMediator {
    override func execute(content: String, num: Int) {
        print("MEDIATOR: Get Info -- \(content)")
        if content == "buy" {
            self.warehouse?.inc(num: num)
            self.sales?.getNotice(content: "Bought \(num)")
        } else if content == "increase" {
            self.sales?.getNotice(content: "Inc \(num)")
            self.purchase?.getNotice(content: "Inc \(num)")
        } else if content == "decrease" {
            self.sales?.getNotice(content: "Dec \(num)")
            self.purchase?.getNotice(content: "Dec \(num)")
        } else if content == "warning" {
            self.sales?.getNotice(content: "Stock is low. \(num) Left")
            self.purchase?.getNotice(content: "Stock is low. Pease Buy More!!! \(num) Left")
        } else if content == "sell" {
            self.warehouse?.dec(num: num)
            self.purchase?.getNotice(content: "Sold \(num)")
        }
    }
}
