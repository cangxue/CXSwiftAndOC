//
//  CXProxy.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/16.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

///托人买火车票
//父协议
@objc protocol showTicketNumberProtocol {
    //展示票号
    @objc optional func showTicketNumber() -> Void
}

//子协议
protocol buyTicketProtocol: showTicketNumberProtocol {
    func buyTicket() -> Void
}


//黄牛票
class ProxyTout: buyTicketProtocol {
    func buyTicket() {
        print("黄牛买票")
    }
    func showTicketNumber() {
        print("123456")
    }
}

//需要买票的Person类
class ProxyPerson: NSObject {
    
    weak var delegate: buyTicketProtocol?
    
}
