//
//  BlockViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/7/27.
//  Copyright © 2017年 CX. All rights reserved.
//


/**
 How Do I Declare A Block in Objective-C?
 
 * As a local variable:局部变量
 returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
 
 * As a property:属性
 @property (nonatomic, copy, nullability) returnType (^blockName)(parameterTypes);
 
 * As a method parameter:函数参数
 - (void)someMethodThatTakesABlock:(returnType (^nullability)(parameterTypes))blockName;
 
 * As an argument to a method call: 调用一个函数参数的block
 [someObject someMethodThatTakesABlock:^returnType (parameters) {...}];
 
 * As a typedef:类型定义
 typedef returnType (^TypeName)(parameterTypes);
 TypeName blockName = ^returnType(parameters) {...};

 
 */

#import "BlockViewController.h"

typedef void(^PrintBlock)(NSString *printStr);

@interface BlockViewController ()

@property (nonatomic, copy, nullable) void (^InputBlock)(NSString *inputStr);

@property (nonatomic, copy, nullable) PrintBlock printBlock;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //局部变量
    NSString *(^OutBlock)(NSString *outStr) = ^NSString *(NSString *outStr) {
        NSLog(@"%@",outStr);

        return @"已经成功输出了局部变量";
    };
    
    NSLog(@"%@",OutBlock(@"请输出局部变量"));
    
    //属性调用
    self.InputBlock = ^(NSString *inputStr) {
        NSLog(@"%@", inputStr);
    };
    _InputBlock(@"请输入属性调用");
    
    //函数调用处理
    [self printStrMethodWithPrintBlock:^(NSString *printStr) {
        NSLog(@"%@",printStr);
    }];
    
    //声明调用
    self.printBlock = ^(NSString *printStr) {
        NSLog(@"%@",printStr);
    };
    self.printBlock(@"打印声明调用");
    
}

- (void)printStrMethodWithPrintBlock:(void (^)(NSString *printStr))otherPrintBlock {
    NSLog(@"这是一个block函数");
    otherPrintBlock(@"函数中block的参数");
}

@end
