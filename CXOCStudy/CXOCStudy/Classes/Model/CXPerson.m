//
//  CXPerson.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/4.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXPerson.h"

@interface CXPerson ()
{
    NSString *isName;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSUInteger age;

@end

@implementation CXPerson

- (void)setName:(NSString *)name {
    
    NSLog(@"-setName: name = %@",name);
    
    _name = name;
}

- (void)setAge:(NSUInteger)age {
    NSLog(@"-setAge: age= %ld",age);
    _age = age;
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"-valueForUnderfinedKey: key = %@",key);
    return nil;
}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"-setNilValueForKey:, key = %@",key);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"-setValue:forUndefinedKey:, value = %@, key = %@",value,key);
}


@end
