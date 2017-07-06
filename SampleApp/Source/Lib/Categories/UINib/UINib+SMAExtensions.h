//
//  UINib+SMAExtensions.h
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (SMAExtensions)

+ (UINib *)nibWithClass:(Class)cls;
+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;


- (id)objectWithClass:(Class)cls;

- (id)objectWithClass:(Class)cls owner:(id)owner;

- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

- (NSArray *)objectsWithOwner:(id)owner options:(NSDictionary *)options;

@end
