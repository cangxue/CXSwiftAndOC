//
//  NSObject+CXSwizzling.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/12/25.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CXSwizzling)
/// 方法替换
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector;

@end
