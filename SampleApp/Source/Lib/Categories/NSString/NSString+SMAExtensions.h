//
//  NSString+SMAExtensions.h
//  SampleApp
//
//  Created by Ievgen on 3/29/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SMAExtensions)

+ (NSString *)sma_stringWithDouble:(double)value;

+ (NSString *)sma_boolStringWithInteger:(NSInteger)value;

@end

