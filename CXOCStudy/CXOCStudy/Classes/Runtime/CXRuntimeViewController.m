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
    /// 获取属性列表
    unsigned int count;
    objc_property_t *propertList = class_copyPropertyList([CXPerson class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertList[i]);
        NSLog(@"property -----> %@", [NSString stringWithUTF8String:propertyName]);
    }
    
    /// 获取方法列表
    Method *methodList = class_copyMethodList([CXPerson class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"mthod -----> %@", NSStringFromSelector(method_getName(method)));
    }
    
    /// 获取成员变量列表
    Ivar *ivarList = class_copyIvarList([CXPerson class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"ivar -----> %@", [NSString stringWithUTF8String:ivarName]);
    }
    
    /// 获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"Protocol -----> %@", [NSString stringWithUTF8String:protocolName]);
    }
}


@end
