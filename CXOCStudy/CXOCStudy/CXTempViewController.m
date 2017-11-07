//
//  CXTempViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXTempViewController.h"

#import "CXBigCheeseBurgerFactory.h"
#import "CXSmallCheeseBurgerFactory.h"
@interface CXTempViewController ()

@end

@implementation CXTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CXCheeseBurger *burger = [CXBigCheeseBurgerFactory printCheeseBurgerNameAndPrice];
    NSLog(@"%@ price is %.2f", burger.name, burger.price);
    
    CXCheeseBurger *smallBurger = [CXSmallCheeseBurgerFactory printCheeseBurgerNameAndPrice];
    NSLog(@"%@ price is %.2f", smallBurger.name, smallBurger.price);
}


@end
