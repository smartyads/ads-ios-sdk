//
//  SMAAdViewBaseTestCase.h
//  SampleApp
//
//  Created by IGavrysh on 5/8/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <SmartyAdsSDK/SmartyAdsSDK.h>

#define kSMASDKTestCaseRequestTimeoutInterval 30.0

@interface SMABannerAdViewBaseTestCase : XCTestCase  <SMABannerAdViewDelegate>
@property (nonatomic, strong)   SMABannerAdView     *bannerAdView;
@property (nonatomic, strong)   UIViewController    *rootViewController;
@property (nonatomic, assign)   BOOL                adDidReceiveAd;
@property (nonatomic, assign)   BOOL                adDidFailToReceiveAd;
@property (nonatomic, assign)   BOOL                adWasClicked;
@property (nonatomic, assign)   BOOL                adWillPresent;
@property (nonatomic, assign)   BOOL                adDidPresent;
@property (nonatomic, assign)   BOOL                adWillClose;
@property (nonatomic, assign)   BOOL                adDidClose;

- (void)_testSuccessfulLoad;
- (void)_testFailedLoad;

- (SMABannerAdView *)mediumAdViewWithPlacementId:(NSString *)placementId;
- (SMABannerAdView *)mediumAdView;
- (SMABannerAdView *)standardBannerAdView;
- (SMABannerAdView *)largeBannerAdView;
- (SMABannerAdView *)adViewWithPlacementId:(NSString *)placementId size:(CGSize)size;

- (CGRect)adViewRectWithSize:(CGSize)size parentView:(UIView *)parentView;

@end
