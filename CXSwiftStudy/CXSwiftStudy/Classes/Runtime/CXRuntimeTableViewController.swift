//
//  CXRuntimeTableViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/8.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class myTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        
//        myTableView.awake

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CXRuntimeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        self.view.addSubview(mainTableView)
        
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "CellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        
        cell.textLabel?.text = "cell"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTableView.reloadData()
    }

}


extension UIApplication {
    
    open override var next: UIResponder? {
            UITableView.awake

            return super.next
    }
}

extension UITableView {
    //静态方法，只执行一次
    static let awake: Void = {
        let originalSelector = #selector(UITableView.reloadData)
        
        let swizzledSelector = #selector(UITableView.sizzle_reloadData)
        
        let originalMethod = class_getInstanceMethod(UITableView.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UITableView.self, swizzledSelector)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()

    //dynamic修饰才能动态调用
    @objc dynamic private func sizzle_reloadData() {
        print("刷新数据吧2")
        //执行刷新
        self.checkEmpty()
        self.sizzle_reloadData()
    }
    
    
    private func checkEmpty() {
        
        var isEmpty: Bool = true
        
        let data_source = self.dataSource
        
        let sections = (data_source?.numberOfSections!(in: self))!
        
        for item in 1...sections {
            
            let rows = (data_source?.tableView(self, numberOfRowsInSection: item))!
            
            if rows > 0 {
                isEmpty = false
                break
            } else {
                isEmpty = true
            }
        }
        
        if isEmpty == true {
            print("数据为空")
            
            let view = UIView(frame: self.bounds)
            view.backgroundColor = UIColor.red
            self.addSubview(view)
            
        } else {
            print("数据不为空")
        }
    }
    
}


