//
//  NSString+SMAExtensions.m
//  SampleApp
//
//  Created by Ievgen on 3/29/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "NSString+SMAExtensions.h"

@implementation NSString (SMAExtensions)

#pragma mark - 
#pragma mark Class Methods

+ (NSString *)sma_stringWithDouble:(double)value {
    return [NSString stringWithFormat:@"%.07f", value];
}

+ (NSString *)sma_boolStringWithInteger:(NSInteger)value {
    return !value ? @"NO" : @"YES";
}

@end
