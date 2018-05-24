//
//  CXBezierPathViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/19.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXBezierPathViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let view = UIView.init(frame: CGRect(x: 100, y: 200, width: 100, height: 14))
        self.view.addSubview(view)
        
        drawTrapezoid(view: view, backgroundColor: UIColor.red, text: "000")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 梯形
    func drawTrapezoid(view: UIView, backgroundColor: UIColor, text: String) {
        let finalSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
 
        let layerHieght = finalSize.height
        
        let layer = CAShapeLayer()
        
        let bezier = UIBezierPath()
        
        bezier.move(to: CGPoint(x: 0, y: finalSize.height - layerHieght))
        bezier.addLine(to: CGPoint(x: 0, y: finalSize.height - 1))
        bezier.addLine(to: CGPoint(x: finalSize.width - 14, y: finalSize.height - 1))
        bezier.addLine(to: CGPoint(x: finalSize.width, y: finalSize.height - layerHieght))
        bezier.addLine(to: CGPoint(x: 0, y: 0))
        
        layer.path = bezier.cgPath
        layer.fillColor = backgroundColor.cgColor
        
        view.layer.addSublayer(layer)
    }
    

}
