//
//  CXOrderDirector.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/14.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXOrderDirector.h"

@implementation CXOrderDirector

+ (CXOrder *)creatOrder:(CXBuilder *)orderBuilder burger:(CXBurger *)burger snack:(CXSnack *)snack {
    orderBuilder.burger = burger;
    orderBuilder.snack = snack;
    CXOrder *order = [orderBuilder build];
    return order;
}

@end
