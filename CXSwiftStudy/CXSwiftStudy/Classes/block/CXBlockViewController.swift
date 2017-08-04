//
//  CXBlockViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/8/3.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

/*
 一般形式
 { (parameters/接收的参数) -> (return type/闭包返回值类型) in
    statements/保存在闭包中需要执行的代码
 }
 
 1.利用typealias为闭包类型定义别名
  typealias type name = type expression
 //为没有参数也没有返回值的闭包类型起一个别名
 typealias Nothing = () -> ()
 
 //如果闭包的没有返回值，那么我们还可以这样写，
 typealias Anything = () -> Void
 
 //为接受一个Int类型的参数不返回任何值的闭包类型 定义一个别名：PrintNumber
 typealias PrintNumber = (Int) -> ()
 
 //为接受两个Int类型的参数并且返回一个Int类型的值的闭包类型 定义一个别名：Add
 typealias Add = (Int, Int) -> (Int)

 */
typealias Nothing = () -> ()

 typealias Add = (Int, Int) -> (Int)

class CXBlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
//        
//        self.declare { (json, isSuccess) in
//            if isSuccess {
//                print("success")
//            }
//        }
//        
//        self.typealiasBlock()
        
        self.addNumber { (num1, num2) -> (Int) in
            print("请打印\(num1 + num2)")
            return num1 + num2
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func declare(completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) ->Void) {
        completion(nil, true)
        
    }
    
    func typealiasBlock() {
        let addCloser: Add
        addCloser = {(_ num1: Int,_ num2: Int) -> (Int) in
            return num1 + num2
        }
        
        print(addCloser(10, 20))
        
        
        
        let printBlock = {(_ printStr: String) -> (String) in
           return printStr
        }
        
        print(printBlock("请打印我"))
        
    }
    
    func addNumber(num: Add) {
        let tempNum = num(50,60)
        
        print(tempNum * 2)
    }

}
