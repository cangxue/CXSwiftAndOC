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
    
    [self passingTest_selectedMethod];
}

#pragma mark - NSArray
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
    
    
    //条件遍历
    NSIndexSet *indexSets = [array indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"second"]) {
            NSLog(@"tow在%lu",(unsigned long)idx);
            *stop = YES;
            return YES;
        }
        
        return NO;
    }];
    
    NSLog(@"%@",indexSets);
    
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

#pragma mark - 集合筛选
//使用KVO
- (void)kvo_selectedMethod {
    NSArray *array = @[@"one", @"two", @"three", @"three", @"three"];
    //获取字符串length
    NSLog(@"%@",[array valueForKeyPath:@"length"]);
    //获取最大length
    NSLog(@"%@",[array valueForKeyPath:@"@max.length"]);
    //去重distinctUnionOfObjects
    NSLog(@"%@",[array valueForKeyPath:@"@distinctUnionOfObjects.self"]);
    //求和
    NSArray *array1 = @[@1, @2, @3];
    NSLog(@"%@",[array1 valueForKeyPath:@"@sum.self"]);
}
//使用NSPredicate
- (void)predicate_selectedMethod {
    NSArray *array = @[@"one", @"two", @"three", @"three", @"three"];
    //条件筛选
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 3"];
    NSLog(@"%@", [array filteredArrayUsingPredicate:predicate]);
    //使用OR和SELF（数据对象本身）
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF ENDSWITH 'o' OR length > 3"];
    NSLog(@"%@",[array filteredArrayUsingPredicate:predicate1]);
    
    //使用block创建
    NSPredicate *predicate2 = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSString *str = evaluatedObject;
        return [str hasSuffix:@"o"] || str.length > 3;
    }];
    NSLog(@"%@", [array filteredArrayUsingPredicate:predicate2]);
}
//使用集合自身的passingTest方法
- (void)passingTest_selectedMethod {
    NSArray *array = @[@"one", @"two", @"three", @"three", @"three"];
    //使用indexesOfObjectsWithOptions
    //NSEnumerationReverse代表从后向前枚举
    NSIndexSet *indexSet = [array indexesOfObjectsWithOptions:NSEnumerationReverse passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = obj;
        if ([str hasSuffix:@"e"] || str.length > 3) {
            return YES;
        }
        return NO;
    }];
    NSLog(@"%@", [array objectsAtIndexes:indexSet]);
}

@end
