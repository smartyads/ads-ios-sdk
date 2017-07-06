//
//  UINib+SMAExtensions.m
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "UINib+SMAExtensions.h"

#import "NSArray+SMAExtensions.h"

@implementation UINib (SMAExtensions)

#pragma mark -
#pragma mark Class methods

+ (UINib *)nibWithClass:(Class)cls {
    return [self nibWithClass:cls bundle:nil];
}

+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    NSString *nibName = NSStringFromClass(cls);
    
    return [self nibWithNibName:nibName bundle:bundle];
}

+ (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil];
}

+ (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls
                           owner:owner
                         options:nil];
}

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options
{
    UINib *nib = [self nibWithClass:cls bundle:nil];
    
    return [nib objectWithClass:cls owner:owner];
}

#pragma mark -
#pragma mark Public methods

- (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner {
    return [[self objectsWithOwner:(id)owner options:nil] objectWithClass:cls];
}

- (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options
{
    return [[self objectsWithOwner:(id)owner options:options] objectWithClass:cls];
}

- (NSArray *)objectsWithOwner:(id)owner options:(NSDictionary *)options {
    return [self instantiateWithOwner:owner options:nil];
}

@end
