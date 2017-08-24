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
    
    [self semaphoreMethod];
    
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"5s后执行");
    });
    
}

#pragma mark - Dispatch Group
- (void)groupMethod {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"first");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"second");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"third");
    });
    
    //将执行的Block追加到Disaptch Queue中
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"main");
    });
    
    //等待全部处理执行结束：等待时间：永久等待
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        NSLog(@"全部处理执行结束");
    } else {
        NSLog(@"某个处理执行中");
    }
    
    long foreverResult = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//恒为0
    long newResult = dispatch_group_wait(group, DISPATCH_TIME_NOW);//不用等待判断是否结束
    
    
    NSLog(@"%ld  %ld",foreverResult, newResult);
    
    //推荐使用dispatch_group_notify
    
}

#pragma mark - dispatch_barrier_async
- (void)barrierMethod {
    dispatch_queue_t queue = dispatch_queue_create("Barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"first");
    });
    dispatch_async(queue, ^{
        NSLog(@"second");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"等一等");
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"third");
    });
    dispatch_async(queue, ^{
        NSLog(@"fourth");
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步执行");
    });
}

#pragma mark - disaptch_apply
- (void)applyMethod {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%ld", index);
    });
    NSLog(@"done");
    
    NSArray *array = @[@"first", @"second", @"third"];
    dispatch_queue_t arryaQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(array.count, arryaQueue, ^(size_t index) {
        NSLog(@"%@",array[index]);
    });
    
    
    dispatch_async(queue, ^{
        /*
         * 等待dispatch_apply函数中全部处理执行结束
         * 类似一个for循环
         */
        dispatch_apply(array.count, queue, ^(size_t index) {
            /*
             * 并列处理包含在NSArray对象的全部对象
             */
            NSLog(@"%@",array[index]);
        });
        
        /*
         * dispatch_apply函数中处理全部执行结束
         *
         * 在 Main Dispatch Queue 中异步执行
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            /*
             * 在Main Dispatch Queue中执行处理
             */

            NSLog(@"done");
        });
    });
}

#pragma mark - dispatch_suspend/dispatch_resume
- (void)resumeMethod {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"暂停");
    });
    dispatch_suspend(queue);//暂停
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        dispatch_resume(queue);//继续
    });
    
    dispatch_async(queue, ^{
        NSLog(@"继续");
    });
}


@end
