//
//  SMAAttrObjectSectionModel.m
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMAAttrObjectSectionModel.h"

#import "SMAAttrObjectModel.h"

@implementation SMAAttrObjectSectionModel

@dynamic count;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sectionWithName:(NSString *)name
                     attributes:(NSArray<NSString *> *)attributes
{
    return [[self alloc] initWithName:name attributes:attributes];
}

+ (instancetype)sectionWithName:(NSString *)name
                         values:(NSArray<SMAAttrObjectModel *> *)values
{
    return [[self alloc] initWithName:name values:values];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithName:(NSString *)name
                  attributes:(NSArray<NSString *> *)attributes
{
    NSMutableArray<SMAAttrObjectModel *> *values = [NSMutableArray new];
    [attributes enumerateObjectsUsingBlock:^(NSString *attribute, NSUInteger idx, BOOL *stop) {
        [values addObject:[SMAAttrObjectModel cellWithAttribute:attribute]];
    }];
    
    return [self initWithName:name values:values];
}

- (instancetype)initWithName:(NSString *)name
                      values:(NSArray<SMAAttrObjectModel *> *)values
{
    self = [super init];
    if (self) {
        self.name = name;
        self.cells = [values mutableCopy];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.cells.count;
}

#pragma mark -
#pragma mark Public Methods

- (SMAAttrObjectModel *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self.cells[index] copy];
}

#pragma mark - 
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    SMAAttrObjectSectionModel *section = [[[self class] allocWithZone:zone] init];
    section.cells = [self.cells copyWithZone:zone];
    section.name = [self.name copyWithZone:zone];
    
    return section;
}

@end
