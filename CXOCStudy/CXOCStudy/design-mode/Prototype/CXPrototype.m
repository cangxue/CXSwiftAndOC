//
//  CXPrototype.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/15.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXPrototype.h"

@implementation CXPrototype

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"Dog";
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CXPrototype *copyLayer = [[[self class] allocWithZone:zone] init];
    copyLayer.background = self.background;
    copyLayer.content = self.content;
    return copyLayer;
}

@end
