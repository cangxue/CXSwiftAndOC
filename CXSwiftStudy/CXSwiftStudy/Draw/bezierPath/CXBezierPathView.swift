//
//  CXBezierPathView.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/6/5.
//  Copyright © 2018年 CX. All rights reserved.
//
// 参考资料：https://blog.csdn.net/dlg1992/article/details/51614136


import UIKit

class CXBezierPathView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        drawRect()
        drawOval()
        drawMorePath()
    }

    // 绘制矩形贝塞尔曲线
    func drawRect() {
        let rect_bezierPath = UIBezierPath(rect: CGRect(x: 30, y: 50, width: 100, height: 100))
        rect_bezierPath.move(to: CGPoint(x: 60, y: 60))
        rect_bezierPath.addLine(to: CGPoint(x: 80, y: 80))
        rect_bezierPath.addLine(to: CGPoint(x: 60, y: 90))
        
        
        rect_bezierPath.lineCapStyle = .butt
        rect_bezierPath.lineJoinStyle = .miter
        rect_bezierPath.miterLimit = 1
        let dash: [CGFloat] = [10,2]
        rect_bezierPath.setLineDash(dash, count: 2, phase: 0)
        rect_bezierPath.lineWidth = 10
        
        UIColor.blue.set()
        rect_bezierPath.fill()
        
        UIColor.black.set()
        rect_bezierPath.stroke()

    }
    
    // 绘制椭圆或圆形贝塞尔曲线
    func drawOval() {
        // 圆形
        let oval_bezierPath = UIBezierPath(ovalIn: CGRect(x: 200, y: 50, width: 150, height: 100))
        oval_bezierPath.lineWidth = 10
      
        // 椭圆贝塞尔曲线
        let rounded_bezierPath = UIBezierPath(roundedRect: CGRect(x: 30, y: 200, width: 100, height: 100), cornerRadius: 20)
        rounded_bezierPath.lineWidth = 10
       
        // 绘制可选择圆角方位的贝塞尔曲线
        let roundedCorner_bezierPath = UIBezierPath(roundedRect: CGRect(x: 200, y: 200, width: 100, height: 100), byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        roundedCorner_bezierPath.lineWidth = 20
        
        // 绘制圆弧曲线
        let arcCenter_bezierPath = UIBezierPath(arcCenter: CGPoint(x: 30, y: 400), radius: 50, startAngle: CGFloat(M_PI / 2 * 3), endAngle: CGFloat(M_PI / 3), clockwise: true)
        arcCenter_bezierPath.lineWidth = 10
        
        UIColor.blue.set()
        oval_bezierPath.fill()
        rounded_bezierPath.fill()
        roundedCorner_bezierPath.fill()
        arcCenter_bezierPath.fill()
        
        UIColor.black.set()
        oval_bezierPath.stroke()
        rounded_bezierPath.stroke()
        roundedCorner_bezierPath.stroke()
        arcCenter_bezierPath.stroke()
    }
    
    // 添加二次、三次贝塞尔曲线
    func drawMorePath() {
        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = 2
        bezierPath.move(to: CGPoint(x: 10, y: 520))
        bezierPath.addLine(to: CGPoint(x: 50, y: 530))
        
        // 添加曲线到该点
        bezierPath.addQuadCurve(to: CGPoint(x: 100, y: 510), controlPoint: CGPoint(x: 80, y: 650))
       
        // 添加二次曲线到该点
        bezierPath.addCurve(to: CGPoint(x: 200, y: 530), controlPoint1: CGPoint(x: 130, y: 600), controlPoint2: CGPoint(x: 170, y: 400))
        
        // 添加圆弧 注:上一个点会以直线的形式连接到圆弧的起点
        bezierPath.addArc(withCenter: CGPoint(x: 300, y: 400), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        
        UIColor.blue.set()
        bezierPath.fill()
        
        UIColor.black.set()
        bezierPath.stroke()
        
        
        // 添加动画
        let aniLayer = CALayer()
        aniLayer.backgroundColor = UIColor.red.cgColor
        aniLayer.position = CGPoint(x: 10, y: 520)
        aniLayer.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
        aniLayer.cornerRadius = 4
        self.layer.addSublayer(aniLayer)
        
        let keyFrameAni = CAKeyframeAnimation(keyPath: "position")
        keyFrameAni.repeatCount = Float(NSIntegerMax)
        keyFrameAni.path = bezierPath.cgPath
        keyFrameAni.duration = 15
        keyFrameAni.beginTime = CACurrentMediaTime() + 1
        aniLayer.add(keyFrameAni, forKey: "keyFrameAnimation")
        
    }

}
