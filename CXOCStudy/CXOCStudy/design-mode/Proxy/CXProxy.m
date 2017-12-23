//
//  CXProxy.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/17.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXProxy.h"

@implementation CXProxy

- (void)responseDelegate {
    if ([self.delegate respondsToSelector:@selector(buyTicket)]) {
        [self.delegate buyTicket];
    }
    
    if ([self.delegate respondsToSelector:@selector(showTicketNumber)]) {
        [self.delegate showTicketNumber];
    }
}

@end
