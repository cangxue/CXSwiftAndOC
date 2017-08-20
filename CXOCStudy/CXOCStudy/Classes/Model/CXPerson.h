//
//  CXPerson.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/4.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXAccount;

@interface CXPerson : NSObject {
    @private
    
    //验证_<key>
    int _age;//年龄
    
    //验证is<key>
    NSString *isSex;//性别
    
    //验证_is<key>
    NSString *_isDate;//时间
}
#pragma mark - 属性
/* 用户名 */
@property (nonatomic, copy) NSString *name;

/* 学校 */
@property (nonatomic, copy) NSString *school;//验证<key>

/* 账户 */
@property (nonatomic, strong) CXAccount *account;

/* 电话号码 */
@property (nonatomic, copy) NSString *tel;

/* nil变量 */
@property (nonatomic, assign) int nilValueKey;

#pragma mark - 公共方法

/* 显示用户信息 */
- (void)showMessage;

- (void)setObject:(id __strong)obj;

@end
