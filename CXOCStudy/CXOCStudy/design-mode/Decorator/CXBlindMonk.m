//
//  CXBlindMonk.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/20.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXBlindMonk.h"

@implementation CXBlindMonk

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"盲僧";
    }
    return self;
}

- (void)learnSkills {
    NSLog(@"盲僧学习技能");
}

@end
