//
//  CollectionViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/6/29.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dictionaryMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Arrays
    func arrayMethod() {
        //初始化一个数组
        let array: NSArray = NSArray.init(objects: "first", "second", "third")
        
        // for...in 遍历
        for item in array {
            print("for... in遍历\(item)");
        }
        // 元组遍历 enumerated() 返回 一个由每一个数据项索引值和数据值组成的元组
        for (index, value) in array.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        
        //闭包循环遍历
        array.enumerateObjects({ (obj, idx, stop) in
            print("闭包循环遍历:\(obj)")
        })
        
        //迭代器遍历
        //正序遍历
        let enu1: NSEnumerator = array.objectEnumerator()
        //反序遍历
        let enu2: NSEnumerator = array.reverseObjectEnumerator()
        
        while let obj: AnyObject = enu1.nextObject() as AnyObject? {
            if obj.isEqual(to: "second") {
                
                break
            }
            
            print("迭代器\(obj)")
            
        }
        
        while let obj: AnyObject = enu2.nextObject() as AnyObject? {
            print("迭代器\(obj)")
        }
        
        
        /************* Array ****************/
        var tempArray: [String] = ["one", "two", "three"]
        tempArray.append("four")
        tempArray.insert("five", at: 4)
        //遍历
        for item in tempArray {
            print(item)
        }
        for (index, value) in tempArray.enumerated() {
            print("遍历 Item \(String(index + 1)): \(value)")
        }
        
        //条件遍历
        let indexSet = array.indexesOfObjects(options: .reverse) { (obj, index, stop) -> Bool in
            let str: NSString = obj as! NSString
            //遍历长度为5的集合
            if str.length == 5 {
                return true
            }
            return false
        }
        
        print("条件遍历\(array.objects(at: indexSet))")
    }
    
    // MARK: - Sets
    func setMethod() {
        var letters = Set<Character>()
        letters.insert("a")
        
        var favorite: Set = ["one", "tow", "three"]
        favorite.remove("tow")
        favorite.insert("two")
        
        for genre in favorite {
            print(genre)
        }
        
        //sorted返回有序数组
        for genre in favorite.sorted() {
            print(genre)
        }
        
        
        /*
         • 使用 intersection(_:) 方法根据两个 合中都包含的值创建的一个新的 合。
         • 使用 symmetricDifference(_:) 方法根据在一个 合中但不在两个 合中的值创建一个新的 合。 
         • 使用 union(_:) 方法根据两个 合的值创建一个新的 合。
         • 使用 subtracting(_:) 方法根据不在该 合中的值创建一个新的 合。
         */
        let oddDigites: Set = [1, 3, 5, 7, 9]
        let evenDiggits: Set = [0, 2, 4, 6, 8]
        let singleDiggitprimeNumber: Set = [2, 3, 5, 6]
        
        print(oddDigites.union(evenDiggits).sorted())
        print(oddDigites.intersection(evenDiggits).sorted())
        print(oddDigites.subtracting(evenDiggits).sorted())
        print(oddDigites.symmetricDifference(singleDiggitprimeNumber).sorted())
        
        /*
         • 使用“是否相等”运算符( == )来判断两个集合是否包含全部相同的值。
         • 使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
         • 使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
         • 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合合或者父集合并且两个集合并不相等。
         • 使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值(是否没有交集)。
         */
        
        let oddDigites1: Set = [1, 3]
        let evenDiggits1: Set = [0, 2, 4, 6]
        
        print(oddDigites1.isSubset(of: oddDigites))//true
        print(oddDigites1.isStrictSuperset(of: oddDigites))//false
        print(evenDiggits.isStrictSuperset(of: evenDiggits1))//true
        print(evenDiggits.isDisjoint(with: oddDigites1))//true
    }
    
    // MARK: - Dictionary
    func dictionaryMethod() {
        //创建一个字典
        var dictionary: Dictionary = ["one": "first", "two": "second", "three": "third"]
        print(dictionary)
        //访问和修改字典
        print(dictionary.count)
        dictionary["one"] = "first_one"
        print(dictionary)
        dictionary.updateValue("second_two", forKey: "two")
        print(dictionary)
        dictionary.removeValue(forKey: "three")
        print(dictionary)
        dictionary.updateValue("third_three", forKey: "three")
        print(dictionary)
        
        //遍历
        for (value, key) in dictionary {
            print("\(key)的key是\(value)")
        }
        for key in dictionary.keys {
            print(key)
        }
        for value in dictionary.values {
            print(value)
        }
        
    }

}
