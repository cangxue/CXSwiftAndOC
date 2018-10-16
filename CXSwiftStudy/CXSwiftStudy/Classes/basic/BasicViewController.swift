//
//  BasicViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/10/17.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    var funllName:String
    {
        get
        {
            return "nickName"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.complex_datatype()
    
        
        print(self.funllName)

    }
    
    // 基础语法
    func basic_datatype() {
        // 字符串
        var str:String = " "
        if str.isEmpty {
            print("空字符串")
        } else {
            print("\(str.count)个字符")
        }
        str = "hello Cangxue.com"
        if str.hasSuffix(".com") {
            print("\(str)有此后缀")
        }
        
        print("大写字母：\(str.uppercased()) 小写字母\(str.lowercased()) 首字母大写\(str.capitalized)")
        
        // 元组
        let tuple = (one: "game", tow: 1234)
        print(tuple.tow)
        
        // 随机数
        let random = Int(arc4random() % 100) + 1
        let random1 = Int(arc4random_uniform(100)) + 1
        print(random, random1)
        
        // 闭区间
        for count in 10...15 {
            print(count)
        }
        // 倒序
        for i in (1..<5).reversed() {
            print(i)
        }
        
        let words = "Hangge.com"
        
        let interval = "a"..."z"
        for c in words.characters {
            if !interval.contains(String(c)){
                print("\(c)不是小写字母")
            }
        }
        
        // 运算符重载
        let pointer1 = CenterPointer(x: 2, y: 3)
        let pointer2 = CenterPointer(x: 4, y: 5)
        let pointer3 = pointer1 + pointer2
        print(pointer3)
    }
    
    // 复杂数据类型
    func complex_datatype() {
        /************* 数组 - Array  ****************/
        let types = ["none","warning","error"]  //省略类型的数组声明
        
        var menbers = [String]() //声明一个空数组
        
        menbers.append("six")  //添加元素
        menbers += ["seven"] //添加元素
        menbers.insert("one", at:0)  //指定位置添加元素
        
        menbers[0] = "message"  //通过下标修改数组中的数据
        menbers[0...2] = ["message","hangge","com"]  //通过小标区间替换数据（前3个数据）
        
        print(menbers.count)  //获取数组元素个数
        print(menbers.isEmpty)  //判断数组是否为空
        
        //交换元素位置（第2个和第3个元素位置进行交换）
        menbers.swapAt(1, 2)
        
        menbers.remove(at: 2)  //删除下标为2的数组
        menbers.removeLast()  //删除最后一个元素
        menbers.removeAll(keepingCapacity: true)  //删除数组中所有元素
        
        let addStringArr = types + menbers //数组组合
        print(addStringArr)
        
        //使用for in 实现数组遍历
        for value in menbers{
            print("\(value)");
        }
        
        //通过enumerate函数同时遍历数组的所有索引与数据
        for (index,value) in menbers.enumerated(){
            print("索引：\(index) 数据：\(value)");
        }
        
        //过滤数组元素
        let newTypes = types.filter {$0.count < 6}
        print(newTypes)
        
        
        /************* 字典 - Dictionary（即键值对） ****************/
        // 1、基本用法
        let empty = [String: Int]()  //建立个空字典
        
        var myDic = ["name":"hangge",
                     "url":"hangge.com"]  //声明一个字典
        
        myDic["address"] = "china" //添加或修改key值
        myDic.removeValue(forKey: "name")  //删除"name"这个key值
        myDic["name"] = nil  //同样可以删除"name"这个key值
        print(myDic.keys)  //访问字典的key集合
        print(myDic.values) //访问字典的values集合
        
        //遍历字典
        for (key,value) in myDic {
            print("\(key):\(value)");
        }
        
        //只遍历字典的键（key）
        for key in myDic.keys {
            print("\(key)");
        }
        
        //只遍历字典的值（value）
        for value in myDic.values {
            print("\(value)");
        }
        
        //过滤字典元素
        let dict2 = myDic.filter { $0.value.count < 7 }
        print(dict2)
        
        /// 2、其它几种创建字典的方法
        //（1）通过元组创建字典
        let tupleArray = [("Monday", 30),  ("Tuesday", 25),  ("Wednesday", 27)]
        let dictionary = Dictionary(uniqueKeysWithValues: tupleArray)
        print(dictionary) //["Monday": 30, "Tuesday": 25, "Wednesday": 27]
        
        //（2）通过键值序列创建字典
        let names = ["Apple", "Pear"]
        let prices = [7, 6]
        let dict = Dictionary(uniqueKeysWithValues: zip(names, prices)) //["Pear": 6,  "Apple": 7]
        print(dict)
        
        //（3）只有键序列、或者值序列创建字典
        let array = ["Monday", "Tuesday", "Wednesday"]
        let dict1 = Dictionary(uniqueKeysWithValues: zip(1..., array))
        let dict3 = Dictionary(uniqueKeysWithValues: zip(array, 1...))
        print("dict1：\(dict1)")
        print("dict2：\(dict3)")
        
        //（4）字典分组（比如下面生成一个以首字母分组的字典）
        let names1 = ["Apple", "Pear", "Grape", "Peach"]
        let dict4 = Dictionary(grouping: names1) { $0.first! }
        print(dict4) //["P": ["Pear", "Peach"], "G": ["Grape"], "A": ["Apple"]]
        
        /// 3、重复键的处理
        //（1）zip配合速记+可以用来解决重复键的问题（相同的键值相加
        let array1 = ["Apple", "Pear", "Pear", "Orange"]
        let dic = Dictionary(zip(array1, repeatElement(1, count: array1.count)), uniquingKeysWith: +)
        print(dic) // ["Pear": 2, "Orange": 1, "Apple": 1]
        
        //（2）下面使用元组创建字典时，遇到相同的键则取较小的那个值
        let duplicatesArray = [("Monday", 30),  ("Tuesday", 25),  ("Wednesday", 27), ("Monday", 28)]
        let dic1 = Dictionary(duplicatesArray, uniquingKeysWith: min)
        print(dic1) // ["Monday": 28, "Tuesday": 25, "Wednesday": 27]
        
        /// 4，字典合并
        var dic11 = ["one": 10, "two": 20]
        //merge方法合并:会修改原始Dictionary
        let tuples = [("one", 5),  ("three", 30)]
        dic11.merge(tuples, uniquingKeysWith: min)
        print("dic：\(dic11)")
        
        //merging方法合并:会创建并返回一个全新的Dictionary
        let dic2 = ["one": 0, "four": 40]
        let dic3 = dic11.merging(dic2, uniquingKeysWith: min)
        print("dic3：\(dic3)")
        
        ///5、默认值
        let dic12 = ["apple": 1, "banana": 2 ]
        var orange:Int
        if let value = dic12["orange"] {
            orange = value
        } else {
            orange = 0
        }
        print(orange)
        
        let dic13 = ["apple": 1, "banana": 2 ]
        let orange1 = dic13["orange", default:0]
        print(orange1)
        
        let str = "apple banana orange apple banana"
        var wordsCount: [String: Int] = [:]
        for word in str.split(separator: " ") {
            wordsCount["\(word)", default: 0] += 1
        }
        print(wordsCount)
        
        /************* 结构体 - struct ****************/
        //创建一个结构体
        struct BookInfo{
            var ID:Int = 0
            var Name:String = "Defaut"
            var Author:String = "Defaut"
        }
        
        var book1:BookInfo //默认构造器创建结构体实例
        var book2 = BookInfo(ID:0021,Name:"航歌",Author:"hangge")  //调用逐一构造器创建实例
        book2.ID = 1234  //修改内部值
        book1 = book2
        book1.ID = 4321
        print(book1.ID, book2.ID)
        
        /************* 枚举 - enum  ****************/
        enum CompassPoint {
            case north
            case south
            case east
            case west
        }
        var directionToHead = CompassPoint.west
        
        enum Planet: Int {
            case mercury = 1
            case venus = 2
            case earth = 3
        }
        let earthsOrder = Planet.earth.rawValue //rawValue来获取他的原始值:3
        let possiblePlanet = Planet(rawValue: 2)  //通过原始值来寻找所对应的枚举成员:Venus
        
        enum Direction {
            case up
            case down
            
            func description() -> String{
                switch(self){
                case .up:
                    return "向上"
                case .down:
                    return "向下"
                }
            }
        }
        print(Direction.up.description())
    }
    
    /// 控制流/控制结构说明
    func control() {
        /// 一、if 语句
        let count = 3
        if count >= 3 {
            print("yes")
        }else{
            print("no")
        }
        
        /// 二、switch 语句
        let fruit = "apple"
        switch fruit{
        case "apple":
            print("good")
            fallthrough
        case "banana","orange":
            print("great")
        default:
            print("bad")
        }
        
        let age = 5
        switch age {
        case 0...11:
            print("正太")
        case 12...30:
            print("少年")
        default:
            print("大叔")
        }
        
        let num = -5
        switch num {
        case ..<0:
            print("负数")
        case 0:
            print("0")
        case 0...:
            print("正数")
        default:
            print("未知")
        }
        
        let point = (2,2)
        switch point {
        case (0,0):
            print("坐标在原点")
        case (_,0):
            print("坐标在x轴上")
        case (0,_):
            print("坐标在y轴上")
        case (-3...3, -3...3):
            print("坐标在长宽为6的正方形内")
        default:
            print("在什么地方")
        }
        
        var height = 1.72
        switch height{
        case 1...3 where height == 1.72:
            print("case 1")
        case 1...3 where height == 2:
            print("case 2")
        default:
            print("default")
        }
        
        /// 三、for 循环语句
        for i in 1..<100{
            print("\(i)")
        }
        
        //遍历数组元素
        let numbers = [1,2,4,7]
        for num in numbers{
            print("\(num)")
        }
        
        //遍历字典
        let nameOfAge = ["lily":18, "Candy":24]
        for (aName, iAge) in nameOfAge{
            print("\(aName) is \(iAge)")
        }
        
        //遍历字符串的字符
        for chare in "hangge".characters {
            print(chare)
        }
        
        (1...10).forEach {
            print($0)
        }
        
        /// 四、while 循环语句
        var i = 10
        
        while i<100 {
            i+=1
        }
        
        repeat{
            i+=1
        } while i<100
        
        
    }
}

// 运算符重载
struct CenterPointer {
    var x = 0, y = 0
}
func + (left: CenterPointer, right: CenterPointer) -> CenterPointer {
    return CenterPointer(x: left.x + right.x, y: left.y + right.y)
}
