//
//  SMASampleAppGeneral.m
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMASampleAppGeneral.h"

CGRect sma_rectWithSizeCenteredInRect(CGSize size, CGRect rect) {
    CGPoint originParent = rect.origin;
    CGSize sizeParent = rect.size;
    CGFloat halfWidth = sizeParent.width / 2.0f;
    CGFloat halfHeight = sizeParent.height / 2.0f;
    
    CGPoint centerParent = CGPointMake(originParent.x + halfWidth,
                                       originParent.y + halfHeight);
    
    CGRect result = CGRectMake(centerParent.x - size.width / 2.0f,
                               centerParent.y - size.height / 2.0f,
                               size.width,
                               size.height);
    
    return result;
}

@implementation SMASampleAppGeneral

@end
