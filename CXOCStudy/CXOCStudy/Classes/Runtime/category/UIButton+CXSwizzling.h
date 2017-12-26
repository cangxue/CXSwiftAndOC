//
//  UIButton+CXSwizzling.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/12/26.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

// 默认时间间隔
#define defaultInterval 1

@interface UIButton (CXSwizzling)

// 点击间隔
@property(nonatomic, assign) NSTimeInterval timeInterval;

// 用于设置单个按钮不需要被hook
@property(nonatomic, assign) BOOL isIgnore;

@end
