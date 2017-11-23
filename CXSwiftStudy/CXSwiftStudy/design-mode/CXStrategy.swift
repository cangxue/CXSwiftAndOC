//
//  CXStrategy.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/23.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit
class CXMsgSender: NSObject {
    var dst_code = ""
    func setCode(code: String) {
        self.dst_code = code
    }
    func send(info: String) {
        return
    }
    
}

class CXCustomer: NSObject {
    var customer_name = ""
    var info = ""
    var phone = ""
    var email = ""
    var send_way: CXMsgSender?
    func setBrdWay(send_way: CXMsgSender) {
        self.send_way = send_way
    }
    func send() {
        self.send_way?.send(info: self.info)
    }
}

class EmailSender: CXMsgSender {
    override func send(info: String) {
        print("EAMIL_ADDRESS: \(self.dst_code) INFO: \(info)")
    }
}

class TextSender: CXMsgSender {
    override func send(info: String) {
        print("TEXT_CODE: \(self.dst_code) INFO: \(info)")
    }
}
