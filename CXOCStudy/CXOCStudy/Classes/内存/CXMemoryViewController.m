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


@end
