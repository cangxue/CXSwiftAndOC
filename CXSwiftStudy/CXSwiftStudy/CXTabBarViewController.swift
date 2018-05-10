//
//  CXTabBarViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/11.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置中心按钮
        setupCustomTabbar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 设置自定义中心按钮
    func setupCustomTabbar() {
        let tabbar = CXCenterTabBar()
        tabbar.itemCount = 2
        self.setValue(tabbar, forKeyPath: "tabBar")
        tabbar.centerButton.addTarget(self, action: #selector(centerButtonClick), for: .touchUpInside)
        
    }
    
    @objc func centerButtonClick() {
        print("点击了")
    }

}

/*
// MARK: --- 自定义中心按钮 ---
extension UITabBar {
    var isWroldCup: Bool? {
        get{
            return false
        }
        set{
            
        }
    }
    
    private struct AssociatedKeys {
        static var TabKey = "tabBar"
    }
    
    //定义一个新的tabbar属性,并设置set,get方法
    var centerButton: UIButton? {
        get{
            //通过Key获取已存在的对象
            return objc_getAssociatedObject(self, &AssociatedKeys.TabKey) as? UIButton
        }
        
        set{
            //对象不存在则创建
            objc_setAssociatedObject(self, &AssociatedKeys.TabKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 添加中心按钮
    func addCustomTabbar() -> UIButton
    {
        if self.centerButton == nil
        {
            self.shadowImage = UIImage()
            
            let top_lineView = UIView(frame: CGRect(x: 0, y: -1, width: self.frame.width, height: 1))
            top_lineView.backgroundColor = UIColor.gray
            self.addSubview(top_lineView)
            
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "world_entry_icon"), for: .normal)
            button.bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
            self.addSubview(button)
            self.centerButton = button
        }
        
        return self.centerButton!
    }
    
    // 设置布局
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isWroldCup == true {
            self.centerButton?.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 10)
            
            var index = 0
            let width = self.frame.size.width / (2 + 1)
            for subView in self.subviews {
                if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                    var frame = subView.frame
                    frame.size.width = width
                    frame.origin.x = CGFloat(integerLiteral: index) * width
                    subView.frame = frame
                    
                    index = index + 1
                    if index == 2 / 2 {
                        index = index + 1
                    }
                }
            }
        }
        
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            if isWroldCup == true {
                let newPoint = self.convert(point, to: self.centerButton)
                
                if (self.centerButton?.point(inside: newPoint, with: event))! {
                    return self.centerButton
                } else {
                    return super.hitTest(point, with: event)
                }
            } else {
                return super.hitTest(point, with: event)
            }
            
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
}

*/
