//
//  CXRxSwiftViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CXRxSwiftViewController: CXBaseViewController {
    
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var resultLabel: UILabel!
    var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        self.mvvmFunc()
        
    }
    
    func setupUI() {
        usernameTextField = UITextField()
        self.view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.right.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        usernameTextField.placeholder = "请输入用户名"
        
        passwordTextField = UITextField()
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(usernameTextField)
        }
        passwordTextField.placeholder = "请输入密码"
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        resultLabel.backgroundColor = UIColor.blue
        self.view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.right.height.equalTo(passwordTextField)
        }

        loginButton = UIButton(type: .custom)
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.right.left.height.equalTo(resultLabel)
        }
        loginButton.setTitle("登录", for: .normal)
        loginButton.backgroundColor = UIColor.blue
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc func loginAction() {
        
    }

}

let disposeBag = DisposeBag()

extension CXRxSwiftViewController {
    func mvvmFunc() {
        
        print("===== \(usernameTextField.rx.text.orEmpty.asDriver())")
        
        let viewModel = CXRxSwiftViewModel(username: usernameTextField.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), loginTap: loginButton.rx.tap.asDriver(), model: CXRxSwiftValidateModel.sharedInstance)
        
//        viewModel.validateLabel.drive(resultLabel.rx.combineResult)
//        viewModel.validateLabel.drive.drive(resultLabel.rx.combinedResult).disposed(by: disposeBag)
        viewModel.loginResult.drive(onNext: { (result) in
            print("------- \(result)")
        }, onCompleted: nil, onDisposed: nil)
        
    }
}

