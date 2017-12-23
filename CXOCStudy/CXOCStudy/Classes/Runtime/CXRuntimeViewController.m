//
//  CXRuntimeViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/9/1.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXRuntimeViewController.h"
#import "CXClass.h"
#import <objc/runtime.h>
#import "CXPerson.h"
#import <objc/message.h>

@interface CXRuntimeViewController () <UITableViewDelegate>

@end

@implementation CXRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self common_method];
}

#pragma mark - 常用方法
- (void)common_method {
    unsigned int outCount = 0;
    
    Class selfClass = [self class];
    Class testClass = [CXClass class];
    
    NSLog(@"===================== 基本信息 =======================");
    
    /// 获取类的类名
    NSLog(@"class name -----> %s", class_getName(testClass));
    
    /// 获取父类
    NSLog(@"super class -----> %s", class_getName(class_getSuperclass(testClass)));
    
    /// 是否是元类
    NSLog(@"CXClass is%@ a meta-class", class_isMetaClass(testClass) ? @"" : @" not");
    
    /// 获取元类
    Class meta_class = objc_getMetaClass(class_getName(testClass));
    NSLog(@"%s meta-class is %s", class_getName(testClass), class_getName(meta_class));
    
    /// 获取实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(testClass));
    
    NSLog(@"===================== 成员变量 =======================");
    
    /// 获取成员变量列表
    Ivar *ivarList = class_copyIvarList(testClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"instance variable name: %s at index: %d", ivar_getName(ivar), i);
    }
    
    free(ivarList);
    
    /// 获取某个成员变量
    Ivar string = class_getInstanceVariable(testClass, "_string");
    if (string != NULL) {
        NSLog(@"instance variable %s", ivar_getName(string));
    }
    
    NSLog(@"===================== 属性操作 =======================");
    
    /// 获取属性列表
    objc_property_t *propertList = class_copyPropertyList(testClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertList[i];
        NSLog(@"property name -----> %s", property_getName(property));
    }
    
    free(propertList);
    /// 获取某个属性
    objc_property_t array = class_getProperty(testClass, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    
    NSLog(@"===================== 方法操作 =======================");
    
    /// 获取所有方法列表
    Method *methodList = class_copyMethodList(testClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        NSLog(@"mthod signature: -----> %@", NSStringFromSelector(method_getName(method)));
    }
    
    free(methodList);
    
    /// 获取实例方法
    Method method1 = class_getInstanceMethod(testClass, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"instance method ------> %@", NSStringFromSelector(method_getName(method1)));
    }
    
    /// 获得类方法
    Method classMethod = class_getClassMethod(testClass, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method ------> %@", NSStringFromSelector(method_getName(classMethod)));
    }
    
    NSLog(@"CXClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(testClass, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    /// 方法实现
    IMP imp = class_getMethodImplementation(testClass, @selector(method1));
    imp(self, @selector(method1));
    
    NSLog(@"===================== 协议 =======================");
    
    /// 获取协议列表
    //    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(testClass, &outCount);
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(testClass, &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Protocol *protocol = protocolList[i];
        NSLog(@"protocol name: -----> %s", protocol_getName(protocol));
    }
    
    Protocol *protocol1 = protocolList[0];
    NSLog(@"CXClass is%@ responsed to protocol %s", class_conformsToProtocol(testClass, protocol1) ? @"" : @"not", protocol_getName(protocol1));
}


@end
