//
//  SMAAdConstants.h
//  SMASDK
//
//  Created by Ievgen on 3/30/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

// 320x50 (standard) banner
extern const CGSize kSMAAdSizeBanner;

// 320x100 large banner
extern const CGSize kSMAAdSizeLargeBanner;

// 300x250 medium rectangel banner
extern const CGSize kSMAAdSizeIABMediumRectangle;

// 468x60 full size banner
extern const CGSize kSMAAdSizeIABFullSizeBanner;

// 728x90 leaderboard
extern const CGSize kSMAAdSizeIABLeaderBoard;


typedef NS_ENUM(NSInteger, SMAAdResponseCode) {
    SMAAdResponseDefaultCode = -1,
    SMAAdResponseSuccessful,
    SMAAdResponseBadURL,
    SMAAdResponseBadURLConnection,
    SMAAdResponseNetworkError,
    SMAAdResponseNonViewResponse,
    SMAAdResponseUnableToFill,
    SMAAdResponseAdViewIsHidden,
    SMAAdResponseFailToLoadHTMLResources
};

typedef NS_ENUM(NSInteger, SMALocationRequestCode) {
    SMADefaultCode = -1,
    SMALocationRequestDenied = 0,
    SMALocationRequestNotDetermined,
    SMALocationRequestDescriptionAbsent,
    SMALocationServicesNotEnabled,
};

typedef NS_ENUM(NSInteger, SMADeviceInfoCode) {
    SMAMacRequestFail = 0
};

typedef NS_ENUM(NSInteger, SMAAppInfoCode) {
    SMAAppInfoIsPurchasedFlagAbsent
};
