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
    
    
}

#pragma mark - 发送消息，调用私有方法
- (void)privateMethod {
    CXPerson *person = objc_msgSend(objc_getClass("CXPerson"), sel_registerName("alloc"));
}

@end
