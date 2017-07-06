//
//  NSArray+SMAExtensions.m
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "NSArray+SMAExtensions.h"

@implementation NSArray (SMAExtensions)

#pragma mark -
#pragma mark Public Methods

- (id)objectWithClass:(Class)cls {
    for (id object in self) {
        if ([object isMemberOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}

@end
