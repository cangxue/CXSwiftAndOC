//
//  CXBigCheeseBurgerFactory.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXBigCheeseBurgerFactory.h"

@implementation CXBigCheeseBurgerFactory

+ (CXCheeseBurger *)printCheeseBurgerNameAndPrice {
    CXCheeseBurger *cheeseBurger = [[CXCheeseBurger alloc] init];
    cheeseBurger.name = @"big cheese burder";
    cheeseBurger.price = 12.0;
    return cheeseBurger;
}

@end
