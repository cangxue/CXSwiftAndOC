//
//  CXOrderDirector.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/14.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXOrder.h"
#import "CXBuilder.h"

@interface CXOrderDirector : NSObject

+ (CXOrder *)creatOrder:(CXBuilder *)orderBuilder burger:(CXBurger *)burger snack:(CXSnack *)snack;

@end
