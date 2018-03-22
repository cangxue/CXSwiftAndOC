//
//  CXSegementViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/22.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CXSegementViewController: CXBaseViewController {
    
    let disposeBag = DisposeBag()
    
    let switch1 = UISwitch()
    
    var button1 = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.switchMethod()
    }

    func switchMethod() {
        switch1.frame = CGRect(x: 20, y: 80, width: 40, height: 30)
        self.view.addSubview(switch1)
        
        button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 20, y: 120, width: view.bounds.size.width - 40, height: 30)
        button1.setTitle("点击一下", for: .normal)
        button1.backgroundColor = UIColor.orange
        self.view.addSubview(button1)
        
        switch1.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前状态是：\($0)")
            })
            .disposed(by: disposeBag)
        
        switch1.rx.isOn
            .bind(to: button1.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    

}
