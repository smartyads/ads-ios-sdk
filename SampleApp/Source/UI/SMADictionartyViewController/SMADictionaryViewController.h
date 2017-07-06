//
//  SMADictionaryViewController.h
//  SampleApp
//
//  Created by IGavrysh on 6/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMADictionaryViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate>

- (instancetype)initWithTitle:(NSString *)sectionTitle dictionary:(NSDictionary *)dictionary;

@end
