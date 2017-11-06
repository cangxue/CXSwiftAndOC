//
//  CXSingleton.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/6.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSingleton.h"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \

@implementation CXSingleton

static CXSingleton *sharedInstance = nil;

+ (instancetype)sharedInstance {
    //用GCD的方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init]; //该方法会调用 allocWithZone
        // 这里可以对实例变量进行初始化
    });
    
//    //使用@synchronized
//    @synchronized(self) {
//        if (sharedInstance == nil) {
//            sharedInstance = [[self alloc] init];
//        }
//    }

    return sharedInstance;
}

//重写allocWithZone方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone]; //确保使用同一块内存地址
    });
    
//    @synchronized(self) {
//        if (sharedInstance == nil) {
//            sharedInstance = [super allocWithZone:zone];
//        }
//    }
    
    return sharedInstance;
}

////使用宏定义
//+ (instancetype)sharedInstance {
//    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
//        return [[self alloc] init];
//    });
//}

@end
