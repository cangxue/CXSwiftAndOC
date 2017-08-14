//
//  CXAutoLayoutViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/14.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXAutoLayoutViewController.h"
#import "Masonry.h"

@interface CXAutoLayoutViewController ()

@end

@implementation CXAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNSlayoutConstraintsView];
    
}

//使用系统的NSLayoutConstraints布局
- (void)setNSlayoutConstraintsView {
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    //默认自动会自动确定自己的位置，要自动布局必须设置为NO
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(64 + 10, 10, 10, 10);
    
    [superview addConstraints:@[
    //上
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:padding.top],
    
    //左
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:padding.left],
    
    //下
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-padding.bottom],
    
    //右
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:-padding.right],
     ]];
}

//使用masonry实现自动布局
- (void)setMasnoryConstraintView {
    
}

@end
