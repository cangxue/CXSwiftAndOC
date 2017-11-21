//
//  CXComposite.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/21.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class Company: NSObject {
    var name = ""
    init(name: String) {
        self.name = name
    }
    
    func add(company: Company) {
        return
    }
    func display(depth: Int) {
        return
    }
    func listDuty() {
        return
    }
    
}

class ConcreateCompany: Company {
    var childrenCompany: [Company] = [Company]()
    
    override init(name: String) {
        super.init(name: name)
        self.childrenCompany = []
    }
    
    override func add(company: Company) {
        self.childrenCompany.append(company)
    }
    override func display(depth: Int) {
        print("\(depth) \(self.name)")
        for component: Company in self.childrenCompany {
            component.display(depth: depth + 1)
        }
    }
    override func listDuty() {
        for component: Company in self.childrenCompany {
            component.listDuty()
        }
    }
}

class HRDepartment: Company {
    override init(name: String) {
        super.init(name: name)
    }
    override func display(depth: Int) {
        print("\(depth) \(self.name)")
    }
    override func listDuty() {
        print("\(self.name) Enrolling & Transfering management.")
    }
}

class FinanceDepartment: Company {
    override init(name: String) {
        super.init(name: name)
    }
    override func display(depth: Int) {
        print("\(depth) \(self.name)")
    }
    override func listDuty() {
        print("\(self.name) Finance Management.")
    }
}

class RdDepartment: Company {
    override init(name: String) {
        super.init(name: name)
    }
    override func display(depth: Int) {
        print("\(depth) \(self.name)")
    }
    override func listDuty() {
        print("\(self.name) Research & Development.")
    }
}
