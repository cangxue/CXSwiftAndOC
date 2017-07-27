//
//  CXBaseViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/7/27.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXBaseViewController.h"
#import "CXHeader.h"

@interface CXBaseViewController ()

//显示label
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation CXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, kScreenWidth - 24, kScreenHeight - 40)];
        _showLabel.numberOfLines = 0;
        _showLabel.layer.masksToBounds = YES;
        _showLabel.layer.cornerRadius = 4;
        _showLabel.layer.borderColor = MAIN_COLOR.CGColor;
        _showLabel.layer.borderWidth = 1;
        _showLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    return _showLabel;
}


@end
