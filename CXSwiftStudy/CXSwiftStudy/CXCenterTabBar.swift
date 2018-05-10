//
//  CXCenterTabBar.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/11.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXCenterTabBar: UITabBar {

    var itemCount = 4
    
    var centerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // top_lineView
        //        let top_lineView = UIView(frame: CGRect(x: 0, y: -1, width: SCREEN_WIDTH, height: 1))
        //        top_lineView.backgroundColor = UIColor.lightGray
        //        self.addSubview(top_lineView)
        
        // centerButton
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "iconImage"), for: .normal)
        button.bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
        self.centerButton = button
        self.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerButton?.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 10)
        
        var index = 0
        let width = self.frame.size.width / CGFloat(integerLiteral: itemCount + 1)
        for subView in self.subviews {
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                var frame = subView.frame
                frame.size.width = width
                frame.origin.x = CGFloat(integerLiteral: index) * width
                subView.frame = frame
                
                index = index + 1
                if index == itemCount / 2 {
                    index = index + 1
                }
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            let newPoint = self.convert(point, to: self.centerButton)
            
            if self.centerButton.point(inside: newPoint, with: event) {
                return self.centerButton
            } else {
                return super.hitTest(point, with: event)
            }
            
        } else {
            return super.hitTest(point, with: event)
        }
    }

}
