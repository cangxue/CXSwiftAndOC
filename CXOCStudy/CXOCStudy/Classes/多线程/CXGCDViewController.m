//
//  CXGCDViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/23.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXGCDViewController.h"

@interface CXGCDViewController ()

@end

@implementation CXGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMethod];
    
}

- (void)createMethod {
    /*********** dispatch_queue_create生成DispatchQueue ************/
    //创建SerialDispatchQueue
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("MySerialDispatchQueue", NULL);
    dispatch_async(mySerialDispatchQueue, ^{
        NSLog(@"执行了SerialDisaptchQueue");
    });
    
    //创建ConcurrentDispatchQueue
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("MyConcurrentDisaptchQueue", DISPATCH_QUEUE_CONCURRENT);
    //执行
    dispatch_async(myConcurrentDispatchQueue, ^{
        NSLog(@"执行了ConcurrentDispatchQueue");
    });
    //释放
//    dispatch_release(myConcurrentDispatchQueue);
    
    
    /*********** 获取系统提供的DispatchQueue ************/
    //获取Main Dispatch Queue
    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
    
    //获取Global Dispatch Queue
    /**
     * 优先级 priority
     * #define DISPATCH_QUEUE_PRIORITY_HIGH 2
     * #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
     * #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
     * #define DISPATCH_QUEUE_PRIORITY_BACKGROUND 后台
     */
    dispatch_queue_t globalDispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    
    dispatch_async(globalDispatchQueue, ^{
        //可并行执行的处理
        NSLog(@"执行globalDispatchQueue");
        dispatch_async(mainDispatchQueue, ^{
            //只能在主线程中执行的处理
            NSLog(@"执行mainDispatchQueue");
        });
    });
    
    /*********** dispatch_set_target_queue ************/
    //变更生成的Dispatch Queue的执行优先级
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueue);
    
    
    /*********** dispatch_after ************/
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"waited at least three seconds");
    });
    
    //绝对时间
    dispatch_time_t (^getDispatchTimeByDate)(NSDate *date) = ^ dispatch_time_t (NSDate *date){
        NSTimeInterval interval;
        double second, subsecond;
        struct timespec time;
        dispatch_time_t milestone;
        
        interval = [date timeIntervalSince1970] + 2;//2s后
        subsecond = modf(interval, &second);
        time.tv_sec = second;
        time.tv_nsec = subsecond * NSEC_PER_SEC;
        //dispatch_walltime 计算绝对时间
        milestone = dispatch_walltime(&time, 0);
        
        return milestone;
    };
    dispatch_after(getDispatchTimeByDate([NSDate new]), dispatch_get_main_queue(), ^{
        NSLog(@"延时执行");
    });
    
}
@end
