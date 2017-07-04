//
//  AppDelegate.m
//  SampleApp
//
//  Created by Ievgen on 3/22/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <SmartyAdsSDK/SmartyAdsSDK.h>

#import "AppDelegate.h"

#import "SMAAdPresentationViewController.h"

#import "UIWindow+SMAExtensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Fabric with:@[[Crashlytics class]]];
    
    [SmartyAds start];
    
    UIWindow *window = [UIWindow fullScreenWindow];
    
    self.window = window;
    
    SMAAdPresentationViewController *controller = [SMAAdPresentationViewController new];
    
    //SMASampleBannerAdViewController *controller = [SMASampleBannerAdViewController new];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];

    //SMAStartLoggingIntoFile();
    
    return YES;
}


@end
