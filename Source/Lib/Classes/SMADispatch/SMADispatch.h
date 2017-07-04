//
//  SMADispatch.h
//
//  Created by Ievgen on 3/12/16.
//  Copyright (c) 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMADispatchQueueType) {
    SMADispatchQueueHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    SMADispatchQueueDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    SMADispatchQueueLow = DISPATCH_QUEUE_PRIORITY_LOW,
    SMADispatchQueueBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
    SMADispatchQueueMain
};

extern
void SMADispatchOnMainQueue(BOOL synchronous, dispatch_block_t block);

extern
void SMADispatchAsyncOnBackgroundQueue(dispatch_block_t block);

extern
void SMADispatchAsyncOnQueue(SMADispatchQueueType type, dispatch_block_t block);

extern
dispatch_queue_t SMADispatchGetQueue(SMADispatchQueueType type);
