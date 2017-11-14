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
//建造者模式
#import "CXBuilder.h"
#import "CXCheeseBurger.h"
#import "CXChipsSnack.h"
#import "CXOrderDirector.h"

@interface CXDesignViewController ()

@end

@implementation CXDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cx_builder];
}
#pragma mark - 建造者模式
- (void)cx_builder {
    //concreteBuilder
    CXCheeseBurger *cheeseBurger = [[CXCheeseBurger alloc] init];
    CXChipsSnack *chipsSnack = [[CXChipsSnack alloc] init];
    
    //builder
    CXBuilder *builder = [[CXBuilder alloc] init];
    builder.burger = cheeseBurger;
    builder.snack = chipsSnack;
    
    //product
    CXOrder *order1 = [builder build];
    NSLog(@"\n%@\n%@",order1.burger.name, order1.snack.name);
    
    //director
    CXOrder *order2 = [CXOrderDirector creatOrder:builder burger:cheeseBurger snack:chipsSnack];
    NSLog(@"\n%@\n%@",order2.burger.name, order2.snack.name);
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
#pragma mark - 单例模式
- (void)cx_singleton {
    CXSingleton *singleton = [CXSingleton sharedInstance];
    singleton.single_name = @"111";
    NSLog(@"%@",singleton.single_name);
    [CXSingleton sharedInstance].single_name = @"222";
    NSLog(@"%@",singleton.single_name);
}


@end
