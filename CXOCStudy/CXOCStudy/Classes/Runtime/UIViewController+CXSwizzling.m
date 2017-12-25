//
//  UIViewController+CXSwizzling.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/12/25.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "UIViewController+CXSwizzling.h"

#import "NSObject+CXSwizzling.h"

@implementation UIViewController (CXSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) swizzledMethod:@selector(sure_viewWillDisappear:)];
    });
}

- (void)sure_viewWillDisappear:(BOOL)animated {
    [self sure_viewWillDisappear:animated];
    
    NSLog(@"去除加载栏等");
}

@end
