//
//  CXMemoryViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/18.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXMemoryViewController.h"
#import "CXPerson.h"

@interface CXMemoryViewController ()
{
    id __strong obj0;
    id __strong obj1;
    
}

@property (nonatomic, copy) NSMutableArray *mainMutableArray;

@end

@implementation CXMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)buildObjectMethod {
    /***  自己生成，自己持有   ***/
    // 自己生成并持有对象
    CXPerson *person1 = [CXPerson new];
    
    // 自己生成并持有对象
    CXPerson *person2 = [[CXPerson alloc] init];
    
    // 基于NSCopying 由类实现copyWithZone: 方法生成并持有对象的副本
    // 不可变更的对象
    CXPerson *person3 = [person1 copy];
    
    // 基于NSMutableCopying 由类实现mutableCopyWithZone: 方法生成并持有对象的副本
    // 可变更的对象
    CXPerson *person4 = [person2 mutableCopy];
    
    
    
     /***  非自己生成的对象，自己持有   ***/
    /*
     - (instancetype)retain OBJC_ARC_UNAVAILABLE;
     - (instancetype)autorelease OBJC_ARC_UNAVAILABLE;
     */
    NSMutableArray *array1 = [NSMutableArray array];
    
    
//    NSLog(@"retain count = %lu", (unsigned long)[person2 retainCount]);
    
    
}

#pragma mark - 强引用
- (void)strongObjectMethod {
    /* 对象A
     * obj0持有对象A的强引用
     */
    obj0 = [[CXPerson alloc] init];
    
    /* 对象B
     * obj1持有对象B的强引用
     */
    
    obj1 = [[CXPerson alloc] init];
    
    //obj2不持有任何对象
    id __strong obj2 = nil;
    
    /*
     * obj0持有有obj1赋值的对象B的强引用
     * 因为obj0被赋值，所以原先持有的对对象A的强引用失效
     * 对象A的所有者不存在因此废弃对象A
     *
     * 此时，持有对象B的强引用的变量为：obj0, obj1
     */
    obj0 = obj1;
    
    
    /*
     * obj2持有由obj0赋值的对象B的强引用
     *
     * 此时，持有对象B的强引用的变量为：obj0, obj1， obj2
     */
    obj2 = obj0;
    
    /*
     * 因为nil被赋值予了obj1,所以对对象B的强引用失效。
     *
     * 此时，持有对象B的强引用的变量为：obj0, obj2
     */
    obj1 = nil;
    
    
    /*
     * 因为nil被赋值予了obj2和obj0,所以对对象B的强引用失效。
     *
     * 此时，持有对象B的强引用的变量没有了
     * 对象B的所有者不存在，因此废弃对象B。
     */
    obj2 = nil;
    obj0 = nil;
    
    /*
     * __strong修饰符的变量，不仅只在变量作用域中，在赋值上也能够
     * 正确的管理对象的所有者
     */
    
    
    /**************************************/
    
    /*
     * test 持有CXPerson对象的强引用
     */
    id __strong test = [[CXPerson alloc] init];
    
    
    [test setObject:[[NSObject alloc] init]];
    /*
     * CXPerson对象的test持有NSObject对象的强引用。
     *
     * 因为test变量超出其作用域，强引用失效
     * 所以自动释放CXPerson对象
     * CXperson对象的所有者不存在，因此废弃该对象。
     *
     * 废弃CXPerson对象的同时，CXPerson对象的boj_成员也被诶起，
     * NSObject对象的强引用失效，
     * 自动释放NSObject对象。
     * NSObject对象的所有者不存在，因此废弃该对象。
     */
    
    
    id __strong obj5; // 等价于id __strong obj5 = nil;

    /*引用计数式内存管理的思考方式
     ******对 __strong修饰符的变量赋值就可达到 *********
     *自己生产的对象，自己所持有;
     *非自己生产的对象，自己也能持有;
     ******废弃带__strong修饰符的变量或者对变量赋值就可达到 *********
     不再需要自己持有的对象时释放;
     ****** 不必再次键入release，所以不会执行 *********
     非自己持有的对象无法释放;
     */
    
    
    /********************************/
    
    //内存泄漏
    
    id test0 = [[CXPerson alloc] init];//对象A
    /*
     * test0持有CXPerson对象A的强引用
     */
    
    id test1 = [[CXPerson alloc] init];//对象B
    /*
     * test1持有CXPerson对象B的强引用
     */
    
    [test0 setObject:obj1];
    /*
     * 对象A 的obj_成员变量持有对象B的强引用
     *
     * 此时持有对象B的强引用的变量为对象A的obj_和test1；
     */
    
    [test1 setObject:test0];
    /*
     * 对象B 的obj_成员变量持有对象A的强引用
     *
     * 此时持有对象A的强引用的变量为对象B的obj_和test0；
     */
    
    /*
     * 因为test0 变量超出其作用域，强引用失效
     * 所以自动释放对象A
     *
     * 因为test1 变量超出其作用域，强引用失效
     * 所以自动释放对象B
     *
     * 此时，持有对象A的强引用的变量为对象B的obj_
     *
     * 此时，持有对象B的强引用的变量为对象A的obj_
     *
     * 发生内存泄漏！
     *
     * 类成员变量的循环引用
     */
    
    
    id test3 = [[CXPerson alloc] init];
    [test3 setObject:test3];
    /*
     * 对自身的强引用引起循环引用
     * 自引用
     */
}

#pragma mark - __weak
//弱引用不能持有对象实例
- (void)weakObjectMethod {
    id __weak obj = [[NSObject alloc] init];//有警告
    /*
     * 将自己生成并持有的对象赋值给__wea修饰的变量obj
     * 变量obj持有对对象的弱引用
     * 为了不以自己持有的状态来保存自己生成并持有的对象，生成的对象会立即被释放
     */
    
    id __strong obj0 = [[NSObject alloc] init];
    /*
     * obj0变量为强引用，所以自己持有对象。
     */
    id __weak obj1 = obj0;
    /*
     * obj1变量持有生成对象的弱引用。
     */
    
    /*
     * 因为obj0变量超出其作用域，强引用失效
     * 所以自动释放自己持有的对象
     * 因为对象的所有者不存在，所以废弃该对象
     *
     * 废弃对象的同时，
     * 持有该对象弱引用的obj1变量的弱引用失效，nil赋值给obj1
     */
    
    /*
     * __weak修饰符的变量（即弱引用）不持有对象，所以在超出其变量作用域时，对象即被释放
     * 在持有某对象的弱引用时，若该对象被废弃，则此弱引用将自动失效且处于nil被赋值的状态（空弱引用）
     * 检查附有__weak修饰符的变量是否为nil，可以判断被赋值的对象是否已废弃
     */
    
    
    
}


- (void)bridgeObjectMethod {
    
    /*************** CFBridgingRetain ／ __bridge_retained 转换 *************/
    //将生成并持有的NSMutableArray对象作为Core Foundation对象来处理
    CFMutableArrayRef cfObject = NULL;
    
    id obj = [[NSMutableArray alloc] init];
    /*
     * 变量obj持有对生成并持有对象的强引用
     */
    
    cfObject = CFBridgingRetain(obj);
//    cfObject = (__bridge_retained id)obj;//等价于上面
    /*
     * 通过CFBridgingRetain，将对象CFRetain，赋值给变量cfObject
     */
    
    CFShow(cfObject);
    printf("retain count = %ld",CFGetRetainCount(cfObject));//2
    /*
     * 通过变量obj的强引用和通过CFBridgingRetain，引用计数为2；
     */
    
    
    printf("retain count = %ld",CFGetRetainCount(cfObject));//1
    /*
     * 因为变量obj超出其作用域，所以其强引用失效，引用计数为1
     */
    CFRelease(cfObject);//0
    /*
     * 因为将对象CFRelease，所以其引用计数为0，故改对象被废弃
     */

    
    
    

}


@end
