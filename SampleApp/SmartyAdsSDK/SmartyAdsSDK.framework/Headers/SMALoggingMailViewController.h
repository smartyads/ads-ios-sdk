	//
//  SMASendLogViewController.h
//  SMASDK
//
//  Created by IGavrysh on 4/14/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@interface SMALoggingMailViewController : MFMailComposeViewController

+ (instancetype)controllerWithDelegate:(id<MFMailComposeViewControllerDelegate>)delegate;

- (instancetype)initWithDelegate:(id<MFMailComposeViewControllerDelegate>)delegate;

@end
