//
//  UIButton+CXSwizzling.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/12/26.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "UIButton+CXSwizzling.h"
#import "NSObject+CXSwizzling.h"

@implementation UIButton (CXSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(sendAction:to:forEvent:) swizzledMethod:@selector(sure_sendAction:to:forEvent:)];
    });
}

/// 当按钮点击事件sendAction 时将执行sure_sendAction
- (void)sure_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.isIgnore) {
        // 不需要被hook
        [self sure_sendAction:action to:target forEvent:event];
        return;
    }
    
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval = self.timeInterval == 0 ? defaultInterval : self.timeInterval;
        if (self.isIgnoreEvent) {
            return;
        } else if (self.timeInterval > 0) {
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    
    self.isIgnoreEvent = YES; // 之后重复点击无效
    [self sure_sendAction:action to:target forEvent:event]; //执行此次点击事件
}

/// runtime 动态绑定属性
// 时间
- (NSTimeInterval)timeInterval {
    // get方法
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
   // set方法
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 此按钮是否忽略设置延时
- (BOOL)isIgnore {
    // get方法
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsIgnore:(BOOL)isIgnore {
    // set方法
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_ASSIGN);
}

// 是否或略此次点击事件
- (BOOL)isIgnoreEvent {
    // get方法
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    // set方法
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

/// 设置 isIgnoreEvent 值：YES 忽略，点击无效  NO：能够点击
- (void)resetState {
    [self setIsIgnoreEvent:NO];
}

@end
