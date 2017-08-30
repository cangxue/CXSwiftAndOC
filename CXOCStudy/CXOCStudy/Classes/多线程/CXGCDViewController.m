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
    
    [self lockMethod];
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

#pragma mark - dispatch_semaphore
- (void)semaphoreMethod {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        dispatch_async(queue, ^{
            /*
             * 等待dispatch semaphore
             * 会使传入的信号量的值减1
             *
             * 一直等待，直到dispatch semaphore 的计数值达到大于等于1
             * 如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；
             * 如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，
             * 当其返回0时表示在timeout之前，该函数所处的线程被成功唤醒。
             */
            long wait = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"wait %ld",wait);
            
            /*
             * 由于dispatch semaphore 的计数值达到大于等于1
             * 所以将dispatch semaphore 的计数值减去1
             * dispatch_semaphore_wait函数执行返回
             *
             * 即执行到此时的dispatch semaphore的计数值恒为0
             *
             * 由于可访问NSMutableArray类对象的线程只有1个
             * 可安全进行更新
             */
            [array addObject:[NSNumber numberWithInt:i]];
            
            /*
             * 通过dispatch_semaphore_signal函数将计数值加1
             *
             * 当返回值为0时表示当前并没有线程等待其处理的信号量，其处理的信号量的值加1即可。
             * 当返回值不为0时，表示其当前有（一个或多个）线程等待其处理的信号量，并且该函数唤醒了一个等待的线程（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）
             */
            long signal = dispatch_semaphore_signal(semaphore);
            NSLog(@"signal %ld",signal);
            
            NSLog(@"done %lu",(unsigned long)array.count);
            
        });

        if (array.count > 0) {
            NSLog(@"done %lu",(unsigned long)array.count);
        }
    }
    
   /*  关于信号量，一般可以用停车来比喻。
       停车场剩余4个车位，那么即使同时来了四辆车也能停的下。如果此时来了五辆车，那么就有一辆需要等待。
    
    　　信号量的值就相当于剩余车位的数目
       dispatch_semaphore_wait函数就相当于来了一辆车
       dispatch_semaphore_signal就相当于走了一辆车。 
       停车位的剩余数目在初始化的时候就已经指明了（dispatch_semaphore_create（long value）），
    
    　　调用一次dispatch_semaphore_signal，剩余的车位就增加一个；调用一次dispatch_semaphore_wait剩余车位就减少一个；
    
    　　当剩余车位为0时，再来车（即调用dispatch_semaphore_wait）就只能等待。有可能同时有几辆车等待一个停车位。有些车主
    
    　　没有耐心，给自己设定了一段等待时间，这段时间内等不到停车位就走了，如果等到了就开进去停车。而有些车主就像把车停在这，
    
    　　所以就一直等下去。
    */

}


#pragma mark - dispatch_once
- (void)onceMethod {
    // 只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         * 初始化
         */
    });
}


#pragma mark - Dispatch I/O
- (void)IOrOMethod {
    //Apple System Log API里的源代码（地址：http://opensource.apple.com/source/Libc/Libc-763.11/gen/asl.c
    
//    创建一个调度I / O通道。
    
    /*
     @Parameters
     
     * type  通道类型 （Dispatch I/O Channel Types.）
     
         #define DISPATCH_IO_STREAM 0
         读写操作按顺序依次顺序进行。在读或写开始时，操作总是在文件指针位置读或写数据。读和写操作可以在同一个信道上同时进行。
         
         #define DISPATCH_IO_RANDOM 1
         随机访问文件。读和写操作可以同时执行这种类型的通道,文件描述符必须是可寻址的。
     
     fd 文件描述符
     
     queue  The dispatch queue
     
     cleanup_handler 发生错误时用来执行处理的 Block
     */
    
    //1.创建一个调度I / O通道，并将其与指定的文件描述符关联。
    dispatch_io_t dispatch_io_create( dispatch_io_type_t type, dispatch_fd_t fd, dispatch_queue_t queue, void (^cleanup_handler)(int error));
    
    //2.创建一个具有关联路径名的调度I / O通道。
    dispatch_io_t dispatch_io_create_with_path( dispatch_io_type_t type, const char* path, int oflag, mode_t mode, dispatch_queue_t queue, void (^cleanup_handler)(int error));
    
    //3.从现有的信道创建一个新的调度I / O信道。
    dispatch_io_t dispatch_io_create_with_io( dispatch_io_type_t type, dispatch_io_t io, dispatch_queue_t queue, void (^cleanup_handler)(int error));
    
//    读写操作
    //1.在指定的信道上调度异步读操作。
    void dispatch_io_read( dispatch_io_t channel, off_t offset, size_t length, dispatch_queue_t queue, dispatch_io_handler_t io_handler);
    /*
     *  dispatch_io_read 函数使用 Global Dispatch Queue 开始并列读取,每当各个分割的文件块读取结束时,将含有 Dispatch Data 传递给 dispatch 函数指定的读取结束时回调用的 Block。
     
     * @Parameters
     
         channel 通道
         
         offset 对于DISPATCH_IO_RANDOM 类型的通道,此参数指定要读取的信道的偏移量。
         
         对于DISPATCH_IO_STREAM 类型的通道,此参数将被忽略，数据从当前位置读取。
         length 从通道读取的字节数。指定size_max继续读取数据直到达到一个EOF。
     
     * 如果处理程序与所做的参数设置为是的，一个空的数据对象，和一个0的错误代码，它意味着该通道达到了文件的结尾。
     
     */
    
    //2.为指定的信道调度一个异步写操作。
    //该函数将指定的数据并提交io_handler块队列在操作的进度报告。如果处理程序的所做的参数设置为“不”，则意味着只有部分数据被写入。如果所做的参数设置为是的，这意味着写操作完成，处理程序将不会再次提交。如果操作成功，则处理程序的错误参数设置为0。
    void dispatch_io_write( dispatch_io_t channel, off_t offset, dispatch_data_t data, dispatch_queue_t queue, dispatch_io_handler_t io_handler);
    
    
//    设置一次读取的大小
    //1.设置一次读取的最大字节
    void dispatch_io_set_high_water( dispatch_io_t channel, size_t high_water);
    //2.设置一次读取的最小字节
    void dispatch_io_set_low_water( dispatch_io_t channel, size_t low_water);
}

#pragma mark - 锁
- (void)lockMethod {
    /**********使用synchronized方式*************/
    //线程1
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"打印1");
            sleep(2);
            
            NSLog(@"打印2");
        }
        sleep(2);
         NSLog(@"打印22");
    });
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"打印4");
        }
    });
    
    /*
     *线程2会等待线程1执行完成@synchronized(obj){}块后，再执行
     */
    
    /**********使用sNSLock方式*************/
    //申明锁对象
    NSLock *lock = [[NSLock alloc] init];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"lock1");
        sleep(5);
        [lock unlock];
    });
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"lock2");
        [lock unlock];
    });
}



@end
