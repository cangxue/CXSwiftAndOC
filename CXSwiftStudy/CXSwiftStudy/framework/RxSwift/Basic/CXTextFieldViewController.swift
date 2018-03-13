//
//  CXTextFieldViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CXTextFieldViewController: CXBaseViewController {
    
    let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.moreText()
        
        
    }

    // 将内容绑定到其他控件上
    func otherControl() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x: 20, y: 80, width: view.frame.width - 40, height: 30))
        inputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输入框
        let outField = UITextField(frame: CGRect(x: 20, y: 120, width: view.frame.width - 40, height: 30))
        outField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(outField)
        
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 160, width: view.frame.width - 40, height: 30))
        self.view.addSubview(label)
        
        //创建按钮
        let button: UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 200, width: 40, height: 30)
        button.setTitle("提交", for: .normal)
        self.view.addSubview(button)
        
        
        //文本内容改变时
        let input = inputField.rx.text.orEmpty.asDriver() //将普通序列转换为 Driver
            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数: \($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5}
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    //同时监听多个 textField 内容的变化
    func moreText() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x: 20, y: 80, width: view.frame.width - 40, height: 30))
        inputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输入框
        let outField = UITextField(frame: CGRect(x: 20, y: 120, width: view.frame.width - 40, height: 30))
        outField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(outField)
        
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 160, width: view.frame.width - 40, height: 30))
        self.view.addSubview(label)
        
        Observable
            .combineLatest(inputField.rx.text.orEmpty, outField.rx.text.orEmpty) {
                textValue1, textValue2 -> String in
                return "您输入的是：\(textValue1) - \(textValue2)"
            }
            .map{ $0 }
            .bind(to: label.rx.text)
            .disposed(by:disposeBag)
        
        //事件监听
        inputField.rx.controlEvent(.editingDidBegin).asObservable()
            .subscribe(onNext: {
                print("开始编辑内容")
            })
            .disposed(by: disposeBag)
        
        inputField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: {
                outField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
        
    }


}
