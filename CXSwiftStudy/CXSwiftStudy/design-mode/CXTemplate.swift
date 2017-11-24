//
//  CXTemplate.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/24.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class StockQueryDevice: NSObject {
    var stock_code = "0"
    var stock_price = 0.0
    
    func login(usr: String, pwd: String) -> Bool {
        return true
    }
    func setCode(code: String) {
        self.stock_code = code
    }
    func queryPrice() {
        return
    }
    func showPrice() {
        return
    }
    
    func operateQuery(usr: String, pwd: String, code: String) -> Bool {
        if self.login(usr: usr, pwd: pwd) {
            self.setCode(code: code)
            self.queryPrice()
            self.showPrice()
            return true
        }
        return false
    }
}

class WebAStockQueryDevice: StockQueryDevice {
    override func login(usr: String, pwd: String) -> Bool {
        if usr == "myStockA" && pwd == "myPwdA" {
            print("Web A: Login OK...user:\(usr) pwd:\(pwd)")
            return true
        } else {
            print("Web A: Login ERROR...user:\(usr) pwd:\(pwd)")
            return false
        }
    }
    override func queryPrice() {
        print("Web A Querying...code:\(self.stock_code)")
        self.stock_price = 20.0
    }
    override func showPrice() {
        print("Web A Stock Price...code:\(self.stock_code) price:\(self.stock_price)")
    }
}
