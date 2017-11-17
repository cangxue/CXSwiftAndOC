//
//  CXProxy.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/11/17.
//  Copyright © 2017年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TicketDelegate <NSObject>

- (void)showTicketNumber;
- (void)buyTicket;

@end

@interface CXProxy : NSObject

@property (nonatomic, weak) id<TicketDelegate>delegate;

- (void)responseDelegate;

@end
