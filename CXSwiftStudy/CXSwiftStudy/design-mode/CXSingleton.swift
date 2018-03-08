//
//  CXSingleton.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/6.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXSingleton: NSObject {
    
    static let sharedInstance = CXSingleton.init()
    
    var height = 10
    
    // 重载并私有
    private override init() {
        // 初始化一些内容
    }
    
}

// 1、直接访问静态属性的方式
// 不能被继承
final class Singleton1: NSObject {
    // 静态变量
    static let shareInstance = Singleton1()
    // 私有变量，类外无法访问
    private override init() {
        print("Singleton 初始化了一次")
        
    }
}

//2、带立即执行的闭包初始化器的全局变量
final class Singleton2: NSObject {
    
    static var shareInstance: Singleton2 = {
        let instance = Singleton2()
        return instance
    }()
    
    private override init(){
        print("Singleton2 初始化了一次")
        
    }
}

//3、结构体实现单例
final class Singleton3: NSObject {
    private class var shared : Singleton3 {
        struct SharedSingleton {
            static let instance = Singleton3()
            
        }
        
        return SharedSingleton.instance
        
    }
    
    class func shareInstance() -> Singleton3 {
        return shared
        
    }
    
    private override init() {
        print("Singleton3 初始化了一次")
        
    }
    
}

//4、定义私有静态变量 通过公有方法访问
final class Singleton4: NSObject {
    
    private static let instance = Singleton4()
    
    class func shareInstance() -> Singleton4 {
        return instance
        
    }
    
    private override init() {
        print("Singleton4 初始化了一次")
        
    }
    
}
