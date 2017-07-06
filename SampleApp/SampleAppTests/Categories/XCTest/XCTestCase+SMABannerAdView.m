//
//  XCTestCase+SMAAdView.m
//  SampleApp
//
//  Created by Ievgen on 5/2/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "XCTestCase+SMABannerAdView.h"

@implementation XCTestCase (SMAAdView)

#pragma mark -
#pragma mark Class Methods

+ (SMABannerAdView *)bannerAdViewWithFrame:(CGRect)frame {
    SMABannerAdView *bannerAdView = [[SMABannerAdView alloc] initWithFrame:frame];
    
    bannerAdView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:bannerAdView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0f
                                                                        constant:frame.size.width];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:bannerAdView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0f
                                                                         constant:frame.size.height];
    
    [bannerAdView addConstraints:@[widthConstraint, heightConstraint]];
    
    return bannerAdView;
}


@end
