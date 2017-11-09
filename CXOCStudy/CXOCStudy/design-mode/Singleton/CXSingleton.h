//
//  CXSingleton.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/6.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSingleton : NSObject

@property (nonatomic, copy) NSString *single_name;

+ (instancetype)sharedInstance;

@end
