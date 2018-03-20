//
//  CXUILabelViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CXUILabelViewController: CXBaseViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 80, width: 300, height: 100))
        self.view.addSubview(label)
        
        //创建文本标签
        let label2 = UILabel(frame: CGRect(x: 20, y: 120, width: 300, height: 100))
        self.view.addSubview(label2)
        
        
        //创建一个计数器
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        // ---  将数据绑定到 text 属性上（普通文本  ---
        timer.map { String(format: "%0.2d:%0.2d.%0.1d",
                           arguments: [($0 / 600) % 600, ($0 % 600) / 10, $0 % 10]) }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)


        // ---  将数据绑定到 attributedText 属性上（富文本)  ---
        timer.map(formatTimeInterval)
        .bind(to: label2.rx.attributedText)
        .disposed(by: disposeBag)
        
    }
    
    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600) / 10, ms % 10])
        
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        
        attributeString.addAttributes([
                                       NSFontAttributeName: UIFont.init(name: "HelveticaNeue-Bold", size: 16)!,
                                       NSForegroundColorAttributeName: UIColor.white,
                                       NSBackgroundColorAttributeName: UIColor.orange,
                                    
                                    ],
                                      range: NSMakeRange(0, 5))
        return attributeString
        
    }


}
