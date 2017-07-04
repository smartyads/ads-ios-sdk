//
//  SMAAttrObjectCellModel.m
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMAAttrObjectModel.h"

static NSString * const kSMANotAvailable = @"N/A";

@implementation SMAAttrObjectModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)cellWithAttribute:(NSString *)attribute {
    return [[self alloc] initWithAttribute:attribute];
}

+ (instancetype)cellWithAttribute:(NSString *)attribute object:(id<NSCopying>)object {
    return [[self alloc] initWithAttribute:attribute object:object];
}

#pragma mark -
#pragma mark Initializations and Deallocations 

- (instancetype)initWithAttribute:(NSString *)attribute {
    return [self initWithAttribute:attribute object:nil];
}

- (instancetype)initWithAttribute:(NSString *)attribute
                           object:(id<NSCopying>)object
{
    self = [super init];
    self.attribute = [attribute copy];
    self.object = object;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)attribute {
    return _attribute ? [_attribute copy] : kSMANotAvailable;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *) zone {
    SMAAttrObjectModel *model = [[[self class] allocWithZone:zone] init];
    model.attribute = self.attribute;
    model.object = self.object;
    
    return model;
}

@end
