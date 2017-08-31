//
//  CXRunLoopViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/31.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXRunLoopViewController.h"

@interface CXRunLoopViewController ()

@property(nonatomic, strong) UIImageView *my_imageView;

@property(nonatomic, strong) UITextView *my_textView;

//后台常驻线程
@property(nonatomic, strong) NSThread *backgroundThread;

@end

@implementation CXRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.my_imageView];
    
    [self.view addSubview:self.my_textView];
    
    self.backgroundThread = [[NSThread alloc] initWithTarget:self selector:@selector(backgroundThreadRun) object:nil];
    [self.backgroundThread start];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.my_imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"chengxuyuan"] afterDelay:4 inModes:@[NSDefaultRunLoopMode]];
    
    // 利用performSelector，在self.thread的线程中调用run2方法执行任务
    [self performSelector:@selector(backgroundThread2) onThread:self.backgroundThread withObject:nil waitUntilDone:NO];
}

#pragma mark - 定义定时器
- (void)addTimer {
   NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    /*
     当我们不做任何操作的时候，RunLoop处于NSDefaultRunLoopMode下。
     而当我们拖动Text View的时候，RunLoop就结束NSDefaultRunLoopMode，
     切换到了UITrackingRunLoopMode模式下，这个模式下没有添加NSTimer，
     所以我们的NSTimer就不工作了。
     但当我们松开鼠标的时候，RunLoop就结束UITrackingRunLoopMode模式，
     又切换回NSDefaultRunLoopMode模式，所以NSTimer就又开始正常工作了
     
     */
    
    // 将定时器添加到当前RunLoop的NSRunLoopCommonModes下
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    //NSTimer会自动被加入到了RunLoop的NSDefaultRunLoopMode模式下
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    
}

#pragma mark - 观察者
- (void)observerMethod {
    //创建观察者
    
    /*
     可以监听的状态改变
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),           // 即将进入Loop：1
     kCFRunLoopBeforeTimers = (1UL << 1),    // 即将处理Timer：2
     kCFRunLoopBeforeSources = (1UL << 2),   // 即将处理Source：4
     kCFRunLoopBeforeWaiting = (1UL << 5),   // 即将进入休眠：32
     kCFRunLoopAfterWaiting = (1UL << 6),    // 即将从休眠中唤醒：64
     kCFRunLoopExit = (1UL << 7),            // 即将从Loop中退出：128
     kCFRunLoopAllActivities = 0x0FFFFFFFU   // 监听全部状态改变
     };
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
}

- (void)run {
    NSLog(@"---run");
}

#pragma mark - 后台常驻线程
- (void)backgroundThreadRun {
    NSLog(@"------后台常驻线程-----");
    
    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
    NSLog(@"未开启RunLoop");
}

- (void)backgroundThread2 {
    NSLog(@"------后台常驻线程backgroundThread2-----");
}
#pragma mark - lazy
- (UIImageView *)my_imageView {
    if (_my_imageView == nil) {
        _my_imageView = [[UIImageView alloc] init];
        _my_imageView.frame = CGRectMake(20, 80, 80, 80);
    }
    
    return _my_imageView;
}

- (UITextView *)my_textView {
    if (_my_textView == nil) {
        _my_textView = [[UITextView alloc] init];
        _my_textView.frame = CGRectMake(20, 180, 200, 80);
        _my_textView.text = @"当我们不做任何操作的时候，RunLoop处于NSDefaultRunLoopMode下。\n 而当我们拖动Text View的时候，RunLoop就结束NSDefaultRunLoopMode，\n切换到了UITrackingRunLoopMode模式下，这个模式下没有添加NSTimer，\n所以我们的NSTimer就不工作了。\n但当我们松开鼠标的时候，RunLoop就结束UITrackingRunLoopMode模式，\n又切换回NSDefaultRunLoopMode模式，所以NSTimer就又开始正常工作了";
    }
    
    return _my_textView;
}

@end
