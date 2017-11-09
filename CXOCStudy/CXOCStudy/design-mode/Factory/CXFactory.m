//
//  CXFactory.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXFactory.h"
#import "CXRedButton.h"

@implementation CXFactory
- (NSObject *)createProduct:(NSString *)className {
    if ([className isEqualToString:@"CXRedButton"]) {
        CXRedButton *btnIns = [[CXRedButton alloc] init];
        return btnIns;
    } else {
        return nil;
    }
}

@end
