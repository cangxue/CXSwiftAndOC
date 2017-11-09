//
//  CXAbstractFactory.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/9.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAbstractFactory : NSObject

- (NSObject *)createButtonProduct;

- (NSObject *)createTextFieldProduct;

@end
