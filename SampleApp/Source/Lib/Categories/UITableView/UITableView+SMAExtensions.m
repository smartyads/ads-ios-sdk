//
//  UITableView+SMAExtensions.m
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "UITableView+SMAExtensions.h"

#import "UINib+SMAExtensions.h"

@implementation UITableView (SMAExtensions)

#pragma mark -
#pragma mark Public Methods

- (id)cellWithClass:(Class)cls {
    return [self cellWithClass:cls bundle:nil];
}

- (id)cellWithClass:(Class)cls bundle:(NSBundle *)bundle {
    NSString *cellClass = NSStringFromClass(cls);
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellClass];
    
    if (!cell) {
        UINib *nib = [UINib nibWithClass:cls bundle:bundle];
        cell = [nib objectWithClass:cls owner:self];
    }
    
    return cell;
}

@end
