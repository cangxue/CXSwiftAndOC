//
//  CXTempViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXTempViewController.h"

#import "CXSimpleFactory.h"
#import "CXRedButton.h"
#import "CXFactory.h"
#import "CXAbstractRedFactory.h"
#import "CXRedTextField.h"

@interface CXTempViewController ()

@end

@implementation CXTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //简单工厂模式
    CXButton *simple_button = [CXSimpleFactory createProduct:@"CXButton"];
    [simple_button display];
    
    //工厂模式
    CXFactory *factory = [[CXFactory alloc] init];
    CXRedButton *redBtn = [factory createProduct:@"CXRedButton"];
    [redBtn display];
    
    //抽象工厂模式
    CXAbstractRedFactory *abstract_factory = [[CXAbstractRedFactory alloc] init];
    CXRedButton *abstract_btn = [abstract_factory createButtonProduct];
    [abstract_btn display];
    CXRedTextField *abstract_field = [abstract_factory createTextFieldProduct];
    [abstract_field display];
}


@end
