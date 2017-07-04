//
//  XCTestCase+SMAAdView.h
//  SampleApp
//
//  Created by Ievgen on 5/2/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <SmartyAdsSDK/SmartyAdsSDK.h>

@interface XCTestCase (SMABannerAdView)

+ (SMABannerAdView *)bannerAdViewWithFrame:(CGRect)frame;

@end
