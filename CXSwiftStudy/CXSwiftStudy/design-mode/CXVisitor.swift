//
//  CXVisitor.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/28.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

/**********药品类***********/
class Medicine: NSObject {
    var name = ""
    var price = 0.0
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    func accept(visitor: Visitor) {
        return
    }
}
//抗生素
class Antibiotic: Medicine {
    override func accept(visitor: Visitor) {
        visitor.visit(medicine: self)
    }
}
//感冒药
class Coldrex: Medicine {
    override func accept(visitor: Visitor) {
        visitor.visit(medicine: self)
    }
}

/**********工作人员类***********/
class Visitor: NSObject {
    var name = ""
    func visit(medicine: Medicine) {
        return
    }
}
//药品划价员
class Charger: Visitor {
    override func visit(medicine: Medicine) {
        print("CHARGER: \(self.name) lists the medicine \(medicine.name) price \(medicine.price)")
    }
}
//药房管理员
class Pharmacy: Visitor {
    override func visit(medicine: Medicine) {
        print("PHARMACY: \(self.name) offers the medicine \(medicine.name) price \(medicine.price)")
    }
}

//药房类
class Prescription: NSObject {
    var medicines: [Medicine] = []
    func addMedicine(medicine: Medicine) {
        self.medicines.append(medicine)
    }
    func visit(visitor: Visitor) {
        for medc in medicines {
            medc.accept(visitor: visitor)
        }
    }
}
