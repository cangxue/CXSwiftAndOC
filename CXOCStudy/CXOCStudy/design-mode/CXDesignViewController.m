//
//  CXDesignViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/10.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXDesignViewController.h"
//单例模式
#import "CXSingleton.h"
//工厂模式
#import "CXSimpleFactory.h"
#import "CXRedButton.h"
#import "CXFactory.h"
#import "CXAbstractRedFactory.h"
#import "CXRedTextField.h"

@interface CXDesignViewController ()

@end

@implementation CXDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 单例模式
- (void)cx_singleton {
    CXSingleton *singleton = [CXSingleton sharedInstance];
    singleton.single_name = @"111";
    NSLog(@"%@",singleton.single_name);
    [CXSingleton sharedInstance].single_name = @"222";
    NSLog(@"%@",singleton.single_name);
}
#pragma mark - 工厂模式
- (void)cx_factory {
    //简单工厂模式
    CXButton *simple_button = [CXSimpleFactory createProduct:@"CXButton"];
    [simple_button display];
    
    //工厂模式
    CXFactory *factory = [[CXFactory alloc] init];
    CXRedButton *redBtn = [factory createProduct:@"CXRedButton"];
    [redBtn display];
    
    //抽象工厂模式
    CXAbstractRedFactory *abstract_factory = [[CXAbstractRedFactory alloc] init];
    CXRedButton *abstract_btn = [abstract_factory createButtonProduct];
    [abstract_btn display];
    CXRedTextField *abstract_field = [abstract_factory createTextFieldProduct];
    [abstract_field display];
}

@end
