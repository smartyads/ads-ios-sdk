//
//  SMAAdViewBaseTestCase.m
//  SampleApp
//
//  Created by IGavrysh on 5/8/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <XCTest/XCTest.h>

#import "SMABannerAdViewBaseTestCase.h"

static NSString * const kSMAMediumAdPlacementId = @"3358";
static NSString * const kSMABannerAdPlacementId = @"3729";
static NSString * const kSMALargeBannerAdPlacementId = @"3730";

@interface SMABannerAdViewBaseTestCase ()
@property (nonatomic, strong)   XCTestExpectation   *adResponseExpectation;
@property (nonatomic, copy)     void (^checkHandler)(SMABannerAdView *adView, NSError *error);

@end

@implementation SMABannerAdViewBaseTestCase

@synthesize bannerAdView = _bannerAdView;

#pragma mark -
#pragma mark Accessors

- (void)setBannerAdView:(SMABannerAdView *)bannerAdView {
    if (_bannerAdView != bannerAdView) {
        if (!_bannerAdView) {
            [_bannerAdView removeFromSuperview];
        }
        
        _bannerAdView = bannerAdView;
        
        if (_bannerAdView) {
            _bannerAdView.delegate = self;
            [self.rootViewController.view addSubview:_bannerAdView];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)setUp {
    [super setUp];
    
    self.adDidFailToReceiveAd = NO;
    self.adDidReceiveAd = NO;
    
    UIApplication *application = [UIApplication sharedApplication];
    self.rootViewController = application.keyWindow.rootViewController;
}

- (void)tearDown {
    [self.bannerAdView removeFromSuperview];
    self.bannerAdView = nil;
    
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    
    self.adResponseExpectation = nil;
    
    [super tearDown];
}

- (void)_testSuccessfulLoad {
    XCTAssert(self.bannerAdView != nil, @"BannerAdView is nil");
    self.adResponseExpectation = [self expectationWithDescription:@"SMABannerAdWebView received/failed response"];

    __weak typeof (self) weakSelf = self;
    
    self.checkHandler = ^(SMABannerAdView *bannerAdView, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        _XCTPrimitiveAssertTrue(weakSelf,
                               [NSThread isMainThread],
                               @"check if notification is on main thread");
        
        NSLog(@"SMABannerAdView Loaded");
        
        _XCTPrimitiveAssertTrue(strongSelf,
                                strongSelf.adDidReceiveAd && !strongSelf.adDidFailToReceiveAd,
                                @"adViewDidLoad: was not called BUT, adView:didFailLoadingWithError: called instead");
        
        [strongSelf.adResponseExpectation fulfill];
    };
    
    [self.bannerAdView load];
    
    [self waitForExpectationsWithTimeout:kSMASDKTestCaseRequestTimeoutInterval handler:nil];
    self.adResponseExpectation = nil;
}

- (void)_testFailedLoad {
    XCTAssert(self.bannerAdView != nil, @"BannerAdView is nil");
    
    self.adResponseExpectation = [self expectationWithDescription:@"SMABannerAdView received/failed response"];
    
    __weak typeof (self) weakSelf = self;
    
    
    self.checkHandler =  ^(SMABannerAdView *adView, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        _XCTPrimitiveAssertTrue(weakSelf,
                                [NSThread isMainThread],
                                @"check if notification is on main thread");
        
        NSLog(@"SMABannerAdView Loaded");
        
        _XCTPrimitiveAssertTrue(strongSelf,
                                !strongSelf.adDidReceiveAd && strongSelf.adDidFailToReceiveAd,
                                @"adView:didFailLoadingWithError: was not called BUT, adViewDidLoad: called instead");
        
        [strongSelf.adResponseExpectation fulfill];
    };
    
    [self.bannerAdView load];
    
    [self waitForExpectationsWithTimeout:kSMASDKTestCaseRequestTimeoutInterval handler:nil];
    self.adResponseExpectation = nil;
}

- (SMABannerAdView *)mediumAdViewWithPlacementId:(NSString *)placementId {
    return [self adViewWithPlacementId:placementId size:kSMAAdSizeIABMediumRectangle];
}

- (SMABannerAdView *)mediumAdView {
    return [self adViewWithPlacementId:kSMAMediumAdPlacementId size:kSMAAdSizeIABMediumRectangle];
}

- (SMABannerAdView *)standardBannerAdView {
    return [self adViewWithPlacementId:kSMABannerAdPlacementId size:kSMAAdSizeBanner];
}

- (SMABannerAdView *)largeBannerAdView {
    return [self adViewWithPlacementId:kSMALargeBannerAdPlacementId size:kSMAAdSizeLargeBanner ];
}

- (SMABannerAdView *)adViewWithPlacementId:(NSString *)placementId size:(CGSize)size {
    UIView *parentView = self.rootViewController.view;
    
    CGRect adRect = [self adViewRectWithSize:size parentView:parentView];
    
    SMABannerAdView *view = [[SMABannerAdView alloc] initWithPlacementId:placementId size:size];
    view.frame = adRect;

    return view;
}

- (CGRect)adViewRectWithSize:(CGSize)size parentView:(UIView *)parentView {
    CGSize adContainerSize = CGSizeMake(300, 250);
    CGSize viewSize = parentView.bounds.size;
    
    CGRect rect = CGRectMake((viewSize.width - adContainerSize.width) / 2.0,
                             (viewSize.height - adContainerSize.height ) / 2.0,
                             adContainerSize.width,
                             adContainerSize.height);
    
    return rect;
}

#pragma mark -
#pragma mark SMAAdDelegate

- (void)adViewDidLoad:(SMABannerAdView *)adView {
    XCTAssertTrue([NSThread isMainThread]);
    
    self.adDidReceiveAd = YES;
    
    if (self.checkHandler) {
        self.checkHandler(adView, nil);
    }
}

- (void)adView:(SMABannerAdView *)adView didFailLoadingWithError:(NSError *)error {
    XCTAssertTrue([NSThread isMainThread]);
    
    self.adDidFailToReceiveAd = YES;
    
    if (self.checkHandler) {
        self.checkHandler(adView, error);
    }
}

@end
