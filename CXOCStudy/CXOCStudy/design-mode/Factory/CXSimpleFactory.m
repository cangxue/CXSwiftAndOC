//
//  CXSimpleFactory.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSimpleFactory.h"

@implementation CXSimpleFactory
+ (CXButton *)createProduct:(NSString *)className {
    Class cl = NSClassFromString(className);
    CXButton *buttonIns = [[cl alloc] init];
    return buttonIns;
}
@end
