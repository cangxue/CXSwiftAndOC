//
//  ViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 17/4/12.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "ViewController.h"
#import "BlockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//block
- (IBAction)blockBtnClick:(id)sender {
    BlockViewController *blockVC = [[BlockViewController alloc] init];
    blockVC.title = @"Block";
    [self.navigationController pushViewController:blockVC animated:YES];
}

@end
