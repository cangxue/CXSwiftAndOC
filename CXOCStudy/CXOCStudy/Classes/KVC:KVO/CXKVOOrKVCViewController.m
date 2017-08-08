//
//  CXKVOOrKVCViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/4.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXKVOOrKVCViewController.h"

#import "CXPerson.h"

@interface CXKVOOrKVCViewController ()

@property (nonatomic, strong) CXPerson *person;

@end

@implementation CXKVOOrKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _person = [[CXPerson alloc] init];
//    _person.name = @"xiaoma";
    
}



@end
