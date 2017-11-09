//
//  CXAbstractRedFactory.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXAbstractRedFactory.h"
#import "CXRedButton.h"
#import "CXRedTextField.h"

@implementation CXAbstractRedFactory

- (NSObject *)createButtonProduct {
    CXRedButton *redBtn = [[CXRedButton alloc] init];
    return redBtn;
}

- (NSObject *)createTextFieldProduct {
    CXRedTextField *redField = [[CXRedTextField alloc] init];
    return redField;
}

@end
