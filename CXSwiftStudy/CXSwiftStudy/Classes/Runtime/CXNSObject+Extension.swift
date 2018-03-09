//
//  CXNSObject+Extension.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/8.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

extension NSObject {
    static func swizzleInstanceSelector(originalSel: Selector, swizzledSelector: Selector) -> Void {
        let originMethod = class_getInstanceMethod(self as AnyClass, originalSel)
        let swizzledMethod = class_getInstanceMethod(self as AnyClass, swizzledSelector)
        
        print(originMethod)
        print(swizzledMethod)
        
        let methodAdded = class_addMethod(self as AnyClass, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if methodAdded {
            class_replaceMethod(self as AnyClass, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod)
        }
        
    }
}
