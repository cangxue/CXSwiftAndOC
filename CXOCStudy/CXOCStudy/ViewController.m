//
//  ViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 17/4/12.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "ViewController.h"
#import "BlockViewController.h"
#import "CXAutoLayoutViewController.h"
#import "CXKVOOrKVCViewController.h"
#import "CXMemoryViewController.h"
#import "CXGCDViewController.h"
#import "CXThreadViewController.h"
#import "CXRunLoopViewController.h"
#import "CXRunLoopViewController.h"

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

//AutoLayout
- (IBAction)autoLayoutBtnClick:(id)sender {
    CXAutoLayoutViewController *vc = [[CXAutoLayoutViewController alloc] init];
    vc.title = @"AutoLayout";
    [self.navigationController pushViewController:vc animated:YES];
}

//KVC／KVO
- (IBAction)kvcOrKvoBtnClick:(id)sender {
    CXKVOOrKVCViewController *vc = [[CXKVOOrKVCViewController alloc] init];
    vc.title = @"KVC／KVO";
    [self.navigationController pushViewController:vc animated:YES];
}

//Memory
- (IBAction)memoryBtnClick:(id)sender {
    CXMemoryViewController *vc =[[CXMemoryViewController alloc] init];
    vc.title = @"Memory";
    [self.navigationController pushViewController:vc animated:YES];
}
//thread
- (IBAction)threadBtnClick:(id)sender {
//    CXGCDViewController *vc =[[CXGCDViewController alloc] init];
    CXRunLoopViewController *vc = [[CXRunLoopViewController alloc] init];
    
    vc.title = @"Thread";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
