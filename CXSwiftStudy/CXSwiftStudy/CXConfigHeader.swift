//
//  CXConfigHeader.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import Foundation

//封装的日志输出功能（T表示不指定日志信息参数类型）
func CXLog<T>(_ message:T, file:String = #file, function:String = #function,
              line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}
