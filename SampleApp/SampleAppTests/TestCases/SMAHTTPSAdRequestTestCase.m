//
//  SMAHTTPSAdRequestTestCase.m
//  SampleApp
//
//  Created by IGavrysh on 5/8/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <SmartyAdsSDK/SmartyAdsSDK.h>

#import "SMABannerAdViewBaseTestCase.h"

@interface SMAHTTPSAdRequestTestCase : SMABannerAdViewBaseTestCase

@end

@implementation SMAHTTPSAdRequestTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHTTPSAdRequest {
    [[SMASDKSettings sharedInstance] setHttpsEnabled:YES];
    
    self.bannerAdView = [self mediumAdView];
    
    [self _testSuccessfulLoad];
}

@end
