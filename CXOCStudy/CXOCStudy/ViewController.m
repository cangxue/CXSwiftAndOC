//
//  ViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 17/4/12.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "ViewController.h"
// 文件管理
#import "CXFileManagerViewController.h"

#import "BlockViewController.h"
#import "CXAutoLayoutViewController.h"
#import "CXKVOOrKVCViewController.h"
#import "CXMemoryViewController.h"
#import "CXGCDViewController.h"
#import "CXThreadViewController.h"
#import "CXRunLoopViewController.h"
#import "CXRunLoopViewController.h"
#import "CXRuntimeViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTalbleView;

@property (nonatomic, copy) NSMutableArray *showArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDataSource/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = _showArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class  class = NSClassFromString(_showArray[indexPath.row]);
    UIViewController *VC = class.new;
    VC.title = _showArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
}

- (NSMutableArray *)showArray {
    if (!_showArray) {
        _showArray = [NSMutableArray arrayWithObjects:@"CXFileManagerViewController", nil];
    }
    return _showArray;
}

@end
