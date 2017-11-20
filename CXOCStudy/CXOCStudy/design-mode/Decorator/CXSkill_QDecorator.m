//
//  CXSkill_QDecorator.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/20.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSkill_QDecorator.h"

@implementation CXSkill_QDecorator

- (instancetype)initWithSkillName:(NSString *)skillName; {
    if (self = [super init]) {
        self.skillName = skillName;
    }

    return self;
}

- (void)learnSkills {
    NSLog(@"%@学习了技能Q：%@",self.hero.name, self.skillName);
}

@end
