//
//  BlockViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/7/27.
//  Copyright © 2017年 CX. All rights reserved.
//


/**
 How Do I Declare A Block in Objective-C?
 
 * As a local variable:局部变量
 returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
 
 * As a property:属性
 @property (nonatomic, copy, nullability) returnType (^blockName)(parameterTypes);
 
 * As a method parameter:函数参数
 - (void)someMethodThatTakesABlock:(returnType (^nullability)(parameterTypes))blockName;
 
 * As an argument to a method call: 调用一个函数参数的block
 [someObject someMethodThatTakesABlock:^returnType (parameters) {...}];
 
 * As a typedef:类型定义
 typedef returnType (^TypeName)(parameterTypes);
 TypeName blockName = ^returnType(parameters) {...};

 
 */


#import "BlockViewController.h"

typedef void(^PrintBlock)(NSString *printStr);

@interface BlockViewController ()

@property (nonatomic, copy, nullable) void (^InputBlock)(NSString *inputStr);

@property (nonatomic, copy, nullable) PrintBlock printBlock;

@property (nonatomic, copy) NSString *item;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self accessVariableMethod];
    
}

#pragma mark - 各种block变量定义
/** block声明 **/
- (void)declareMethod {
    
    //局部变量
    NSString *(^OutBlock)(NSString *outStr) = ^NSString *(NSString *outStr) {
        NSLog(@"%@",outStr);
        
        return @"已经成功输出了局部变量";
    };
    
    NSLog(@"%@",OutBlock(@"请输出局部变量"));
    
    //属性调用
    self.InputBlock = ^(NSString *inputStr) {
        NSLog(@"%@", inputStr);
    };
    _InputBlock(@"请输入属性调用");
    
    //函数调用处理
    [self printStrMethodWithPrintBlock:^(NSString *printStr) {
        NSLog(@"%@",printStr);
    }];
    
    //声明调用
    self.printBlock = ^(NSString *printStr) {
        NSLog(@"%@",printStr);
    };
    self.printBlock(@"打印声明调用");
}

- (void)printStrMethodWithPrintBlock:(void (^)(NSString *printStr))otherPrintBlock {
    NSLog(@"这是一个block函数");
    otherPrintBlock(@"函数中block的参数");
}

/** block测试 **/
- (void)testAccessVariable {
    NSInteger outsideVarible = 10;
    
    void (^blockObject)(void) = ^(void) {
        NSLog(@"outsideVarible %ld", (long)outsideVarible);
    };
    
    outsideVarible = 20; 
    
    blockObject();
}

#pragma mark - 循环引用
- (void)cycleMethod {
    
    /*
     self持有printBlock，而堆上的printBlock又会持有self，所以会导致循环引用
     */
//    self.printBlock = ^(NSString *printStr) {
//        self.item = printStr;
//    };
    
    /*
     可以通过使用将strong（强引用）用weak（弱引用）代替来解决循环引用
     */
//    __weak typeof(self) weakSelf = self;
//    self.printBlock = ^(NSString *printStr) {
//        weakSelf.item = printStr;
//    };
    
    
    /*
     weakSelf与其缺陷
     情况：
     1、若从A push到B，10s之内没有pop回A的话，B中item = @“循环引用”。
     
     2、若从A push到B，10s之内pop回A的话，B会立即执行dealloc，从而导致B中item = (null)。这种情况就是使用weakSelf的缺陷，可能会导致内存提前回收
     */
//    __weak typeof(self) weakSelf = self;
//    self.printBlock = ^(NSString *printStr) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            weakSelf.item = printStr;
//        });
//    };

    
    /*
     weakSelf和strongSelf
     理解：
     1、这么做和直接用self有什么区别，为什么不会有循环引用：外部的weakSelf是为了打破环，从而使得没有循环引用，而内部的strongSelf仅仅是个局部变量，存在栈中，会在block执行结束后回收，不会再造成循环引用。
     
     2、这么做和使用weakSelf有什么区别：唯一的区别就是多了一个strongSelf，而这里的strongSelf会使ClassB的对象引用计数＋1，使得ClassB pop到A的时候，并不会执行dealloc，因为引用计数还不为0，strongSelf仍持有ClassB，而在block执行完，局部的strongSelf才会回收，此时ClassB dealloc。
     */
    __weak typeof(self) weakSelf = self;
    self.printBlock = ^(NSString *printStr) {
        
        __strong typeof(self) strongSelf = weakSelf;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            strongSelf.item = printStr;
            
            NSLog(@"%@",strongSelf.item);
        });
    };
    
    
    /*
     宏定义
     @weakify和@strongify
     对weakSelf 和 strongSelf进行宏定义偏于引用，CXHeader.h
     */
    @weakify(self);
    self.printBlock = ^(NSString *printStr) {
        
        @strongify(self);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.item = printStr;
            NSLog(@"%@",self.item);
        });
    };
    
    
    self.printBlock(@"循环引用");
}

#pragma mark - 注意
//变量调用
- (void)accessVariableMethod {
    
    NSInteger outsideVariable = 10;
    
    //blockObject 在实现时会对 outside 变量进行只读拷贝，在 block 块内使用该只读拷贝
    //如果，我们想要让 blockObject 修改或同步使用 outside 变量就需要用 __block 来修饰 outside 变量。
//    __block NSInteger outsideVariable = 10;
    
    
    NSMutableArray * outsideArray = [[NSMutableArray alloc] init];
    
    self.printBlock = ^(NSString *printStr) {
        NSLog(@"%@ = %ld",printStr,(long)outsideVariable);
        
        [outsideArray addObject:@"AddedInsideBlock"];
    };
    
    outsideVariable = 30;
    
    self.printBlock(@"outsideVariable");
    
    NSLog(@"outsideArray count is  %lu", (unsigned long)outsideArray.count);
    
    
    /**
     a)，在上面的 block 中，我们往 outsideArray 数组中添加了值，但并未修改 outsideArray 自身，这是允许的，因为拷贝的是 outsideArray 自身。
     
     b)，对于 static 变量，全局变量，在 block 中是有读写权限的，因为在 block 的内部实现中，拷贝的是指向这些变量的指针。
     
     c)， __block 变量的内部实现要复杂许多，__block 变量其实是一个结构体对象，拷贝的是指向该结构体对象的指针。
     */
}

@end
