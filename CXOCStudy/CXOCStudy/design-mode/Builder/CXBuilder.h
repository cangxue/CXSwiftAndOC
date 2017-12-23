//
//  CXBuilder.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/13.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXBurger.h"
#import "CXSnack.h"
#import "CXOrder.h"

@interface CXBuilder : NSObject

@property (nonatomic, strong) CXBurger *burger;
@property (nonatomic, strong) CXSnack *snack;


- (CXOrder *)build;

@end
