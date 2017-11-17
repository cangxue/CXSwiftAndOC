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
//原型模式
#import "CXPrototype.h"
//代理模式
#import "CXProxy.h"

@interface CXDesignViewController () <TicketDelegate>

@end

@implementation CXDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cx_proxy];
}
#pragma mark - 代理模式
- (void)cx_proxy {
    CXProxy *proxy = [[CXProxy alloc] init];
    proxy.delegate = self;
    [proxy responseDelegate];
}
- (void)buyTicket {
    NSLog(@"买了票");
}
- (void)showTicketNumber {
    NSLog(@"123456");
}
#pragma mark - 原型模式
- (void)cx_prototype {
    CXPrototype *prototype = [[CXPrototype alloc] init];
    prototype.background = [NSMutableArray arrayWithObjects:@"1", @"1", @"1", @"1", nil];
    prototype.content = @"Dog";
    NSLog(@"Original %p %@",prototype, prototype.content);
    NSLog(@"===================");
    
    //copy
    CXPrototype *copy_prototype = prototype;
    copy_prototype.content = @"Cat";
    NSLog(@"Original %p %@",prototype, prototype.content);
     NSLog(@"Copy %p %@",copy_prototype, copy_prototype.content);
    NSLog(@"===================");
    
    //deep copy
    CXPrototype *deep_copy_protyope = prototype.copy;
    deep_copy_protyope.content = @"Duck";
    NSLog(@"Original %p %@",prototype, prototype.content);
    NSLog(@"Copy %p %@",copy_prototype, copy_prototype.content);
    NSLog(@"Deep %p %@",deep_copy_protyope, deep_copy_protyope.content);
    
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
