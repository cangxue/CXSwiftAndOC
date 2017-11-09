//
//  CXSingletonViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXSingletonViewController.h"
#import "CXSingleton.h"

@interface CXSingletonViewController ()

@end

@implementation CXSingletonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CXSingleton *singleton = [CXSingleton sharedInstance];
                              
    singleton.single_name = @"singleton";
    
    NSLog(@"%@",[CXSingleton sharedInstance].single_name);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
