//
//  CXRuntimeViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/9/1.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXRuntimeViewController.h"

//#import <objc/runtime.h>
#import "CXPerson.h"
#import <objc/message.h>

@interface CXRuntimeViewController ()

@end

@implementation CXRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self privateMethod];
}

#pragma mark - 发送消息，调用私有方法
- (void)privateMethod {
    //初始化person
    CXPerson *person = objc_msgSend(objc_getClass("CXPerson"), sel_registerName("alloc"));
    person = objc_msgSend(person, sel_registerName("init"));
    
    //调用方法：必须先定义原型才可以使用
    //无参数无返回值
    objc_msgSend(person, @selector(printMessage1));
    ((void(*)(id, SEL))objc_msgSend)(person, @selector(printMessage1));
    //带一参数但是没有返回值
    ((void(*)(id,SEL,NSString *))objc_msgSend)(person, @selector(printMessage2:), @"带一参数但是没有返回值");
    NSString *str = @"hello, world";
    ((void(*)(id,SEL,NSString *))objc_msgSend)(person, @selector(printMessage2:),str);
    //带返回值，但是不带参数的方法
    NSString *returnStr = ((NSString *(*)(id, SEL))objc_msgSend)((id)person, @selector(printMessage3));
    NSLog(@"%@",returnStr);
    
    //带返回值，带参数的方法
    NSString *returnStr1 = ((NSString *(*)(id, SEL, NSString *))objc_msgSend)(person, @selector(printMessage4:), @"带返回值，带参数的方法");
    NSLog(@"%@", returnStr1);
    
}

@end
