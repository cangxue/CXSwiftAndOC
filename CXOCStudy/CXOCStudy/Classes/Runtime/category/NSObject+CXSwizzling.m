//
//  NSObject+CXSwizzling.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/12/25.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "NSObject+CXSwizzling.h"
@implementation NSObject (CXSwizzling)

/// 方法替换
/**
 * class: 类
 * SEL: 方法名称
 * IMP: 方法的实现
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector {
    Class cls = [self class];
    // 原有方法
    // 如果这个类没有实现originalSelector，但其父类实现了，那class_getInstanceMethod会返回父类的方法。
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    // 替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    // 先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    // class_addMethod会添加一个覆盖父类的实现，但不会取代原有类的实现
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) { //添加成功：说明原SEL没有实现IMP，将原SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else { // 添加失败：说明原SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
