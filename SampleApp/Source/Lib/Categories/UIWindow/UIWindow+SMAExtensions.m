//
//  UIWindow+SMAExtensions.m
//  SampleApp
//
//  Created by IGavrysh on 5/11/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "UIWindow+SMAExtensions.h"

@implementation UIWindow (SMAExtensions)

#pragma mark -
#pragma mark Class Methods

+ (UIWindow *)fullScreenWindow {
    return [[UIWindow alloc] initFullScreenWindow];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (UIWindow *)initFullScreenWindow {
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
