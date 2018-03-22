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
    
    var segmented = UISegmentedControl()
    
    let label = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.segmentedMethod()
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
    
    func segmentedMethod() {
        
        segmented = UISegmentedControl(items: ["first", "second", "third", "four"])
        segmented.frame = CGRect(x: 30, y: 120, width: 250, height: 30)
        segmented.selectedSegmentIndex = 0
        self.view.addSubview(segmented)
        
        segmented.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: {
                print("当前项：\($0)")
            })
            .disposed(by: disposeBag)
        
        
        label.frame = CGRect(x: 30, y: 180, width: 250, height: 30)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        self.view.addSubview(label)
        
        segmented.rx.selectedSegmentIndex.asObservable()
            .map { item in
                return self.segmented.titleForSegment(at: item)
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    

}
