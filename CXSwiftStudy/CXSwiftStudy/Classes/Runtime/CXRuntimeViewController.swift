
//
//  CXRuntimeViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/8.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit


class CXRuntimeViewController: CXBaseViewController {
    
    var buttonOne: UIButton!
    var buttonTwo: UIButton!
    
    var test: TestSwizzling!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

        test = TestSwizzling()
        
    }

    func setupUI() {
        buttonOne = UIButton(frame: CGRect(x: 20, y: 80, width: 100, height: 30))
        buttonOne.setTitle("button1", for: .normal)
        buttonOne.backgroundColor = UIColor.blue
        buttonOne.addTarget(self, action: #selector(buttonOneAction), for: .touchUpInside)
        self.view.addSubview(buttonOne)
        
        buttonTwo = UIButton(frame: CGRect(x: 200, y: 80, width: 100, height: 30))
        buttonTwo.setTitle("button2", for: .normal)
        buttonTwo.backgroundColor = UIColor.red
        buttonTwo.addTarget(self, action: #selector(buttonTwoAction), for: .touchUpInside)
        self.view.addSubview(buttonTwo)
        
    }
    
    @objc func buttonOneAction() {
//        print(test.methodOne())
        
        let vc = CXRuntimeTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @objc func buttonTwoAction() {
//        print(test.methodTwo())
        
    }

}

class TestSwizzling: NSObject {
    
    override init() {
        
//        TestSwizzling.awake()
    }

}
//
//protocol SelfAware: class {
//     static func awake()
//}
//
//extension NSObject: SelfAware {
//
//    static func awake() {
//        let originalSelector = #selector(TestSwizzling.methodOne)
//
//        let swizzledSelector = #selector(TestSwizzling.methodTwo)
//
//        self.swizzleInstanceSelector(originalSel: originalSelector, swizzledSelector: swizzledSelector)
//    }
//
//    @objc dynamic func methodOne() -> Int {
//        return 1
//    }
//
//    @objc dynamic func methodTwo() -> Int {
//        return 2
//    }
//
//    static func swizzleInstanceSelector(originalSel: Selector, swizzledSelector: Selector) -> Void {
//        let originMethod = class_getInstanceMethod(self as AnyClass, originalSel)
//        let swizzledMethod = class_getInstanceMethod(self as AnyClass, swizzledSelector)
//
//        let methodAdded = class_addMethod(self as AnyClass, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//        if methodAdded {
//            class_replaceMethod(self as AnyClass, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
//        } else {
//            method_exchangeImplementations(originMethod, swizzledMethod)
//        }
//    }
//
//}






