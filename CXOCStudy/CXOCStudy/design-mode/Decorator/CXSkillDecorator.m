//
//  CXSkillDecorator.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/20.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSkillDecorator.h"

@implementation CXSkillDecorator

- (void)setHero:(CXHero *)hero {
    _hero = hero;
}

- (void)learnSkills {
    if (self.hero != nil) {
        [self.hero learnSkills];
    }
}


@end
