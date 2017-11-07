//
//  CXSmallCheeseBurgerFactory.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSmallCheeseBurgerFactory.h"

@implementation CXSmallCheeseBurgerFactory

+ (CXCheeseBurger *)printCheeseBurgerNameAndPrice {
    CXCheeseBurger *cheeseBurger = [[CXCheeseBurger alloc] init];
    cheeseBurger.name = @"small cheese burder";
    cheeseBurger.price = 6.0;
    return cheeseBurger;
}
@end
