//
//  CXOperation.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/30.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXOperation.h"

@implementation CXOperation

- (void)main {
    for (int i = 0; i < 2; ++i) {
        NSLog(@"1-----%@",[NSThread currentThread]);
    }
}

@end
