//
//  CXSkill_QDecorator.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/20.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSkillDecorator.h"

@interface CXSkill_QDecorator : CXSkillDecorator

- (instancetype)initWithSkillName:(NSString *)skillName;

@property (nonatomic, copy) NSString *skillName;

@end
