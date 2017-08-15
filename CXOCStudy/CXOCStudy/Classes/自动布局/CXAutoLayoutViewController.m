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
    
    [self setMasnoryConstraintView];
    
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
    
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor orangeColor];
    
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor redColor];
    
    [superview addSubview:view1];
    
    [superview addSubview:view2];
    
    [superview addSubview:view3];
    
    [superview addSubview:view4];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(64 + 10, 10, 10, 10);

    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(superview.mas_top).with.offset(padding.top);
//        make.left.equalTo(superview.mas_left).with.offset(padding.left);
//        make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
//        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
        
        make.edges.equalTo(superview).with.insets(padding);
        
    }];
    
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_top).with.offset(padding.left);
        make.leading.equalTo(view1.mas_leading).with.offset(padding.left);
        make.width.equalTo(view3);
        make.height.equalTo(@100);
    }];
    
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_right).with.offset(padding.left);
        make.trailing.equalTo(view1.mas_trailing).with.offset(-padding.left);
        make.height.equalTo(view2);
        make.width.equalTo(view2);
        make.centerY.equalTo(view2.mas_centerY);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).with.offset(padding.bottom);
        make.leading.equalTo(view2.mas_leading);
        make.trailing.equalTo(view3.mas_trailing);
        make.height.equalTo(view3.mas_height);
    }];
    
    
}

@end
