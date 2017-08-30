//
//  CXThreadViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/30.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXThreadViewController.h"

@interface CXThreadViewController ()

@end

@implementation CXThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 创建、启动线程
- (void)createThreadMethod {
    //先创建线程，再启动线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(initRun) object:nil];
    [thread start];
    
    //创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(backRun) toTarget:self withObject:nil];
    
    //隐式创建并启动线程
    [self performSelectorInBackground:@selector(selfRun) withObject:nil];
}

- (void)initRun {
    [NSThread mainThread];
}

- (void)backRun {
    NSThread *current = [NSThread currentThread];
    NSLog(@"%@", current.name);
}

- (void)selfRun {
    NSThread *current = [NSThread currentThread];
    if (current.isMainThread) {
        NSLog(@"这是主线程");
        [current setName:@"主线程"];
    } else {
        [current setName:@"次线程"];
    }
    
}

@end
