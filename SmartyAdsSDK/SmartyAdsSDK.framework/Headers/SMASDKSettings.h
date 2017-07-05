//
//  SMASDKSettings.h
//  SMASDK
//
//  Created by Ievgen on 4/21/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMABaseURLConfig <NSObject>
@property (nonatomic, strong)   NSString    *adRequestBaseURLString;
@property (nonatomic, strong)   NSString    *webViewBaseURLString;

+ (id<SMABaseURLConfig>)sharedInstance;

@end

@interface SMASDKSettings : NSObject
/**
 If set YES, makes all requests by using HTTPS protocol, default value is NO
 */
@property (nonatomic, assign, getter=isHTTPSEnabled)    BOOL    httpsEnabled;

/**
 Can be set externally for modifying ad reqests routing logics
 */
@property (nonatomic, strong, readonly) id<SMABaseURLConfig>    baseURLConfig;

+ (instancetype)sharedInstance;

+ (BOOL)isBaseURLInExceptionDomains;

@end
