//
//  CXOperationViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/30.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXOperationViewController.h"
#import "CXOperation.h"

@interface CXOperationViewController ()

@end

@implementation CXOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建
- (void)createMethod {
    //1. 使用子类- NSInvocationOperation:
    // 1.创建NSInvocationOperation对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationRun) object:nil];
    // 2.调用start方法开始执行操作
    [op start];
    
    ////////////////////////////
    //2. 使用子类- NSBlockOperation
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"------%@", [NSThread currentThread]);
    }];
    [op1 start];
    
    // 添加额外的任务(在子线程执行)
    [op1 addExecutionBlock:^{
        NSLog(@"2------%@", [NSThread currentThread]);
    }];
    //addExecutionBlock:方法中的操作是在其他线程中执行的。
    
    
    ////////////////////////////
    CXOperation *op2 = [[CXOperation alloc] init];
    [op2 start];
}


#pragma mark - (void)addOperation:(NSOperation *)op;
//需要先创建任务，再将创建好的任务加入到创建好的队列中去
//NSInvocationOperation和NSOperationQueue结合后能够开启新线程，
//进行并发执行NSBlockOperation和NSOperationQueue也能够开启新线程，进行并发执行。
- (void)createOperationQueueMethod {
    //主队列
    //凡是添加到主队列中的任务（NSOperation），都会放到主线程中执行
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSLog(@"%@",queue.name);
    
    //其他队列（非主队列）
    //添加到这种队列中的任务（NSOperation），就会自动放到子线程中执行
    //同时包含了：串行、并发功能
    
    // 1.创建队列
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    // 2. 创建操作
    // 创建NSInvocationOperation
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationRun) object:nil];
    // 创建NSBlockOperation
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"------%@", [NSThread currentThread]);
    }];
    [queue1 addOperation:op];//[op1 start]
    [queue1 addOperation:op1];//[op2 start]
}

- (void)invocationRun {
    NSLog(@"------%@", [NSThread currentThread]);
}

#pragma mark - (void)addOperationWithBlock:(void (^)(void))block;
//无需先创建任务，在block中添加任务，直接将任务block加入到队列中。
//addOperationWithBlock:和NSOperationQueue能够开启新线程，进行并发执行。
- (void)addOperationWithBlock {
    //1、创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //2、添加操作到队列中：addOperationWithBlock:
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"-----%@", [NSThread currentThread]);
        }
    }];
}

#pragma mark - 控制串行执行和并行执行的关键
- (void)operationQueue {
    //创建线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //设置最大并发操作数
    queue.maxConcurrentOperationCount = 2;//为1就变成串行队列
    
    //添加操作
    [queue addOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"3-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"4-----%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
}

#pragma mark -  操作依赖
//比如说有A、B两个操作，其中A执行完操作，B才能执行操作，那么就需要让B依赖于A。
- (void)addDependency {
    NSOperationQueue *quque = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread  currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    }];
    
    // 让op2 依赖于 op1，则先执行op1，在执行op2
    [op2 addDependency:op1];
    
    [quque addOperation:op1];
    [quque addOperation:op2];
}

@end
