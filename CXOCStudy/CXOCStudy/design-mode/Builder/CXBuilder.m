//
//  CXBuilder.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/13.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXBuilder.h"

@implementation CXBuilder

- (CXOrder *)build {
    CXOrder *order = [[CXOrder alloc] init];
    order.burger = self.burger;
    order.snack = self.snack;
    return order;
}

@end
