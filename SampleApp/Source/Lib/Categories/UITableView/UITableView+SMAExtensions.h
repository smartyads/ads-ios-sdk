//
//  UITableView+SMAExtensions.h
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SMAExtensions)

- (id)cellWithClass:(Class)cls;

- (id)cellWithClass:(Class)cls bundle:(NSBundle *)bundle;

@end
