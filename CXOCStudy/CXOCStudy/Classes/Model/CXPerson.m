//
//  CXPerson.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/4.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXPerson.h"

@interface CXPerson ()

@end

@implementation CXPerson

#pragma mark - 公共方法
//显示用户信息
- (void)showMessage {
    NSLog(@"\n name = %@,\n age = %d,\n shcool = %@,\n tel = %@,\n sex = %@,\n date = %@", _name, _age, _school, _tel, isSex, _isDate);
}

#pragma mark - 动态设置属性
//setName, 验证set<key>
- (void)setName:(NSString *)name {
    _name = name;
    NSLog(@"setName: name方法：name = %@",name);
}

//如果它的参数类型不是一个对象指针类型,但是值为nil,就会执行setNilValueForKey:方法,
//setNilValueForKey:方法的默认实现,是产生一个NSInvalidArgumentException的异常
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"为key = %@设置的值为nil",key);
}

//没有key时调用
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"没有此key = %@",key);
}

//上面的setter方法没有找到，如果类方法accessInstanceVariablesDirectly返回YES
//(注：这是NSKeyValueCodingCatogery中实现的类方法，默认实现为返回YES)。
//那么按_<key>，_is<Key>，<key>，is<key>的顺序搜索成员名。
//否则执行forUndefinedKey方法
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

#pragma mark - 动态获取属性
//获取值优先调用
- (NSString *)tel {
    NSLog(@"获取值key = %@ 优先调用了此方法",_tel);
    return _tel;
}

//无法获取到key 调用此方法
- (id)valueForUndefinedKey:(NSString *)key {
    NSString *tempStr = [NSString stringWithFormat:@"查询不到key = %@",key];
    return tempStr;
}



@end
