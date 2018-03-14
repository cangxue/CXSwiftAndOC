//
//  CXUIButtonViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CXUIButtonViewController: CXBaseViewController {

    let disposeBag = DisposeBag()
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 80, width: view.bounds.size.width - 40, height: 30)
        button.setTitle("点击一下", for: .normal)
        button.backgroundColor = UIColor.orange
        self.view.addSubview(button)
        
        self.button_title()
        
    
    }
    
    //按钮点击响应
    func button_tap() {
        button.rx.tap
            .subscribe(onNext: {
                print("按钮被电击了")
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind {
                print("按钮被再次电击了")
            }
            .disposed(by: disposeBag)
    }
    
    //按钮标题的绑定
    func button_title() {
        Observable.of("请点击我！")
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: disposeBag)

        Observable.of("请再次点击我！")
            .map(formatTimeInterval)
            .bind(to: button.rx.attributedTitle())
            .disposed(by: disposeBag)
        
        Observable.of("back")
            .map { imagename in
                
                return UIImage(named: imagename)
            }
            .bind(to: button.rx.image())
            .disposed(by: disposeBag)
    }
    
    //富文本
    func formatTimeInterval(string: String) -> NSMutableAttributedString {
        
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
