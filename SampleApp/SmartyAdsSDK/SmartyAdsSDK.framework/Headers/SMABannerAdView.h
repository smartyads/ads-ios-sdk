//
//  SMAAdView.h
//  SMAModelConcept
//
//  Created by IGavrysh on 5/20/17.
//  Copyright © 2017 Gavrysh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMABannerAdView;

@protocol SMABannerAdViewDelegate<NSObject>

@optional

- (void)adViewWillLoad:(SMABannerAdView *)adView;

- (void)adViewDidLoad:(SMABannerAdView *)adView;

- (void)adView:(SMABannerAdView *)adView didFailLoadingWithError:(NSError *)error;

- (void)adViewWasClicked:(SMABannerAdView *)adView;

- (void)adViewWillLeaveApplication:(SMABannerAdView *)adView;

// By default = YES - Ad Container is requesting location (GPS or WiFi) everytime before sending ad request
- (BOOL)shouldRequestPreciseLocation;

// By default = YES - Ad Container is checking availability for each resource link available in Ad
- (BOOL)shouldCheckAdLinks;

@end

@interface SMABannerAdView : UIView
@property (nonatomic, assign)   NSTimeInterval                  autoRefreshInterval;

@property (nonatomic, weak)     id<SMABannerAdViewDelegate>     delegate;

- (instancetype)initWithPlacementId:(NSString *)placementId size:(CGSize)size;

- (void)load;

- (void)cancelLoad;

- (void)forceRefreshAd;

- (void)startAutomaticallyRefreshingContentsWithTimeInterval:(NSTimeInterval)timeInterval;

- (void)stopAutomaticallyRefreshingContents;

- (NSDictionary *)adConsumerInfo;

@end
