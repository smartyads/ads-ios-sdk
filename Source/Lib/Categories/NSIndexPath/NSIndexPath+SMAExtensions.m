//
//  NSIndexPath+SMAExtensions.m
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "NSIndexPath+SMAExtensions.h"

@implementation NSIndexPath (SMAExtensions)

#pragma mark -
#pragma mark Class Methods

+ (NSIndexPath *)indexPathForIndex:(NSUInteger)index {
    return [NSIndexPath indexPathForItem:index inSection:0];
}

@end
