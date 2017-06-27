//
//  CollectionViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/6/26.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setMehod];
}

#pragma mark - NSArray类
- (void)arrayMethod {
    //初始化一个数组
    NSArray *array = [NSArray arrayWithObjects:@"first", @"second", @"third", nil];
    
    /* 顺次访问数组中的元素 */
    //1、快速遍历： for in
    for (NSString *item in array) {
        NSLog(@"快速遍历  %@",item);
    }
    //2、索引访问： count
    for (NSInteger i = 0; i < array.count; i++) {
        NSLog(@"索引访问  %@",[array objectAtIndex:i]);
    }
    //3、使用 NSEnumerator 对象
    NSEnumerator *enumerator = [array objectEnumerator];
    NSString *item = nil;
    while (item = [enumerator nextObject]) {
        NSLog(@"NSEnumerator  %@",item);
    }
    
    /* 访问数组中的单个元素 */
    NSString *lastItem, *firstItem, *otherItem;
    //最后一个元素
    lastItem = [array lastObject];
    //第一个元素
    firstItem = [array firstObject];
    //index为1的元素
    otherItem = [array objectAtIndex:1];
    //otheritem所在的索引值
    NSInteger otherIndex;
    otherIndex = [array indexOfObject:otherItem];
    NSLog(@"单个元素  %@   %@   %@   %ld",lastItem, firstItem, otherItem, otherIndex);
    
    
    /* 访问数组中的一组元素 */
    NSRange range = NSMakeRange(1, 2);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    NSArray *subItems = [array objectsAtIndexes:indexSet];
    NSLog(@"一组元素  %@",subItems);
    
}

#pragma mark - NSDictionary
- (void)dictionaryMethod {
    //初始化字典
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"1", @"one",
                          @"2", @"two",
                          @"3", @"three",
                          nil];
    /* 访问对象中的元素 */
    NSLog(@"%@",[dict objectForKey:@"one"]);
    
    /* 访问对象中的多个元素 */
    NSArray *keys = [NSArray arrayWithObjects:@"one", @"tow", @"ten", nil];
    NSArray *items = [dict objectsForKeys:keys notFoundMarker:[NSNull null]];
    NSLog(@"%@", items);
    
    /* 访问对象中的键和对象 */
    NSArray *objects = [dict allValues];
    NSArray *allKeys = [dict allKeys];
    NSLog(@"%@,   %@",objects, allKeys);
}

#pragma mark - NSSet
- (void)setMehod {
    //初始化一个集合
    NSSet *set = [NSSet setWithObjects:@"one", @"two", @"three", nil];

    /* 访问集合中的元素 */
    NSLog(@"%@", [set member:@"one"]);//输出one
    NSLog(@"%@", [set anyObject]);//输出任意一个
    NSLog(@"%@", [set allObjects]);//输出所有对象
    NSLog(@"%d", [set containsObject:@"two"]);//判断是否包含
    
    //遍历
    NSEnumerator *enumerator = [set objectEnumerator];
    NSString *item = nil;
    while (item = [enumerator nextObject]) {
        NSLog(@"%@", item);
    }
    
    //NSSet的子类，记录对象的次数
    NSCountedSet *countSet = [[NSCountedSet alloc] initWithSet:set];
    //多次加入相同的对象，记录加入对象的次数，但实际上只存储一次
    [countSet addObject:@"one"];
    [countSet addObject:@"one"];
    [countSet addObject:@"one"];

    //遍历
    NSEnumerator *enumerator2 = [countSet objectEnumerator];
    NSLog(@"enumerator2 == %@",enumerator2.allObjects);//输出：enumerator2 == (one,two,three)
    NSString *item2 = nil;
    while (item2 = [enumerator2 nextObject]) {
        NSLog(@"==== %@", item2);
    }
    
    //获取次数
    NSLog(@"%ld", [countSet countForObject:@"one"]);
    
    [countSet removeObject:@"one"];
    NSLog(@"=== %lu", (unsigned long)[countSet countForObject:@"one"]);
    
    
}

@end
