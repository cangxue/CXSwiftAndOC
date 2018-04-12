

//
//  CXShakeableProtocol.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/4/12.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

protocol CXShakeableProtocol { }

extension CXShakeableProtocol where Self: UIView {
    func shake() {
        // implementation code
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue.init(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
