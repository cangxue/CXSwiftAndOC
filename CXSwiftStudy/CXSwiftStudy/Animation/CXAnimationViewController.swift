//
//  CXAnimationViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/29.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXAnimationViewController: CXBaseViewController {
  
    var view1: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        
        positionAnima(animationView: view1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSubviews() {
        view1 = UIView(frame: CGRect(x: 20, y: 80, width: 50, height: 50))
        view1.backgroundColor = UIColor.blue
        self.view.addSubview(view1)
    }

}

// MARK: --- CABasicAnimation ---
/**
 * duration: 动画时长
 * repeatCount: 重复的次数。不停重复设置为 HUGE
 * repeatDuration: 设置动画的时间。在该时间内动画一直执行，不计次数。
 * beginTime: 指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
 * timingFunction: 设置动画的速度变化
 * autoreverses: 动画结束时是否执行逆动画
 * fromValue: 所改变属性的起始值
 * toValue: 所改变属性的结束时的值
 * byValue: 所改变属性相同起始值的改变量
 */
extension CXAnimationViewController {
    //  移动动画实现
    func positionAnima(animationView: UIView) {
        let positionAnima = CABasicAnimation(keyPath: "position.y")
        positionAnima.duration = 0.8
        positionAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        positionAnima.repeatCount = HUGE
        positionAnima.repeatDuration = 5
        positionAnima.isRemovedOnCompletion = false
        positionAnima.fillMode = kCAFillModeForwards
        positionAnima.fromValue = animationView.center.y
        positionAnima.toValue = animationView.center.y - 30
        
        animationView.layer.add(positionAnima, forKey: "AnimationMoveY")
        
    }
}
