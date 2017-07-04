//
//  UIColor+SMAExtensions.m
//  SampleApp
//
//  Created by IGavrysh on 5/5/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "UIColor+SMAExtensions.h"

@implementation UIColor (SMAExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)randomColor {
    float red = arc4random() % 256 / 255.f;
    float green = arc4random() % 256 / 255.f;
    float blue = arc4random() % 256 / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

#pragma mark -
#pragma mark PublicMethods 

- (float)brightness {
    CGFloat *componentColors = (CGFloat *)CGColorGetComponents(self.CGColor);
    
    return (componentColors[0] * 299 + componentColors[1] * 587 + componentColors[2] * 114) / 1000.f;
}

@end
