//
//  SMAAdViewTestCase.m
//  SampleApp
//
//  Created by Ievgen on 5/1/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <XCTest/XCTest.h>
#import <SmartyAdsSDK/SmartyAdsSDK.h>

#import "SMABannerAdViewBaseTestCase.h"

#define kSMASDKRequestTimeoutInterval 30.0

static NSString * const kSMAMediumAdPlacementId = @"3358";
static NSString * const kSMABannerAdPlacementId = @"3729";
static NSString * const kSMALargeBannerAdPlacementId = @"3730";

#define tester KIFActorWithClass(KIFUITestActor)

@interface SMABannerAdViewTestCase : SMABannerAdViewBaseTestCase

@end

@implementation SMABannerAdViewTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMediumAdView {
    self.bannerAdView = [self mediumAdView];
    
    [self _testSuccessfulLoad];
}

- (void)testStandardBannerAdView {
    self.bannerAdView = [self standardBannerAdView];
    
    [self _testSuccessfulLoad];
}

- (void)testLargeBannerAdView {
    self.bannerAdView = [self largeBannerAdView];
    [self _testSuccessfulLoad];
}

- (void)testCoveredMediumAdView {
    UIView *coverView = [self mediumAdViewCover];
    
    self.bannerAdView = [self mediumAdView];
    [self.rootViewController.view addSubview:coverView];
    
    [self _testFailedLoad];
    
    [coverView removeFromSuperview];
}

- (void)testFrontAdView {
    UIView *coverView = [self mediumAdViewCover];
    
    [self.rootViewController.view addSubview:coverView];
    self.bannerAdView = [self mediumAdView];
    
    [self _testSuccessfulLoad];

    [coverView removeFromSuperview];
}

- (void)testAdViewWithIncorrectPlacementId1 {
    self.bannerAdView = [self mediumAdViewWithPlacementId:@"-1"];
    
    [self _testFailedLoad];
}

- (void)testAdViewWithIncorrectPlacementId2 {
    self.bannerAdView = [self mediumAdViewWithPlacementId:@"3355"];
    
    [self _testFailedLoad];
}

- (void)testAdViewPlacedOutsideOfMainScreenBounds {
    SMABannerAdView *bannerAdView = [self mediumAdView];
    CGSize initialFrameSize = bannerAdView.frame.size;
    CGRect mainViewBounds = self.rootViewController.view.bounds;
    CGRect frame = CGRectMake(mainViewBounds.origin.x + mainViewBounds.size.width + 100,
                              mainViewBounds.origin.y + mainViewBounds.size.height + 100,
                              initialFrameSize.width,
                              initialFrameSize.height);
    [bannerAdView setFrame:frame];
    
    self.bannerAdView = bannerAdView;
    
    [self _testFailedLoad];
}

- (void)testAdViewNotAttachedToMainWindow  {
    SMABannerAdView *bannerAdView = [self mediumAdView];
    
    self.bannerAdView = bannerAdView;
    [self.bannerAdView removeFromSuperview];
    
    [self _testFailedLoad];
}

#pragma mark -
#pragma mark Private Methods

- (UIView *)mediumAdViewCover {
    UIView *parentView = self.rootViewController.view;
    UIView *view = [[UIView alloc] initWithFrame:[self mediumAdCoverRectForParentView:parentView]];
    view.backgroundColor = [UIColor blueColor];
    
    return view;
}

- (CGRect)mediumAdCoverRectForParentView:(UIView *)parentView {
    CGRect rect = [self adViewRectWithSize:kSMAAdSizeIABMediumRectangle parentView:parentView];
    
    return CGRectMake(0, 0, rect.origin.x + rect.size.width+1, 800);
}

@end
