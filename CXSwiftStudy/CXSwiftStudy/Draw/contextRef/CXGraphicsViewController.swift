//
//  CXGraphicsViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/6/6.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXGraphicsViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawText()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - 文字
    func drawText() {
        let drawStr: NSString = "我的剑就是你的贱"
        let helveticaBold = UIFont.init(name: "HelveticaNeue-Bold", size: 30.0)
        drawStr.draw(at: CGPoint(x: 20, y: 100), withAttributes: [NSFontAttributeName: helveticaBold as Any, NSForegroundColorAttributeName: UIColor.green])
        
    }
    
    // MARK: - 直线
    func drawLine() {
        // 获取画布
        let context = UIGraphicsGetCurrentContext()
        // 线条颜色
        stroc
    }

}

class CGView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 获取画布
        let context = UIGraphicsGetCurrentContext()
        let path = CGMutablePath()
        cgpathMo
    }
}
