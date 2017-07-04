//
//  SMADispatch.m
//
//  Created by Ievgen on 3/12/16.
//  Copyright (c) 2017 SmartyAds. All rights reserved.
//

#import "SMADispatch.h"

void SMADispatchOnMainQueue(BOOL synchronous, dispatch_block_t block) {
    dispatch_queue_t queue = SMADispatchGetQueue(SMADispatchQueueMain);

    if (synchronous) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(queue, block);
        }
    } else {
        dispatch_async(queue, block);
    }
}

void SMADispatchAsyncOnBackgroundQueue(dispatch_block_t block) {
    return SMADispatchAsyncOnQueue(SMADispatchQueueBackground, block);
}

void SMADispatchAsyncOnQueue(SMADispatchQueueType type, dispatch_block_t block) {
    dispatch_queue_t queue = SMADispatchGetQueue(type);
    
    dispatch_async(queue, block);
}

dispatch_queue_t SMADispatchGetQueue(SMADispatchQueueType type) {
    if (SMADispatchQueueMain == type) {
        return dispatch_get_main_queue();
    }
    
    return dispatch_get_global_queue(type, 0);
}
