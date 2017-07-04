//
//  SMAAttrObjectTableViewModel.m
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMAAttrObjectContainerModel.h"

#import "SMAAttrObjectSectionModel.h"
#import "SMAAttrObjectModel.h"

@interface SMAAttrObjectContainerModel()

- (void)executeBlockForEachAttrObjectModel:(void (^)(SMAAttrObjectModel *model, BOOL *stop))block;

@end

@implementation SMAAttrObjectContainerModel

@dynamic count;

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)modelWithSections:(NSArray<SMAAttrObjectSectionModel *> *)sections {
    return [[self alloc] initWithSections:sections];
}

#pragma mark -
#pragma mark Initializations and Deallocations 

- (instancetype)initWithSections:(NSArray<SMAAttrObjectSectionModel *> *)sections {
    self = [super init];
    self.sections = [sections mutableCopy];
    
    return self;
}

#pragma mark -
#pragma mar Accessors

- (NSUInteger)count {
    return self.sections.count;
}

#pragma mark -
#pragma mark Public Methods

- (void)addSectionWithName:(NSString *)name
                    values:(NSArray<SMAAttrObjectModel *> *)values
{
    SMAAttrObjectSectionModel *section = [SMAAttrObjectSectionModel sectionWithName:name
                                                                           values:values];
    [self.sections addObject:section];
}

- (SMAAttrObjectSectionModel *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self.sections[index] copy];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    __block id object = nil;
    
    [self executeBlockForEachAttrObjectModel:^(SMAAttrObjectModel *model, BOOL *stop) {
        if ([model.attribute isEqualToString:key]) {
            object = model.object;
            *stop = YES;
        }
    }];
    
    return object;
}

- (void)setObject:(id<NSCopying>)object forKeyedSubscript:(NSString *)key {
    [self executeBlockForEachAttrObjectModel:^(SMAAttrObjectModel *model, BOOL *stop) {
        if ([model.attribute isEqualToString:key]) {
            model.object = object;
        }
    }];
}

#pragma mark -
#pragma mark Private Methods

- (void)executeBlockForEachAttrObjectModel:(void (^)(SMAAttrObjectModel *model, BOOL *stop))block {
    if (!block) {
        return;
    }
    
    [self.sections enumerateObjectsUsingBlock:^(SMAAttrObjectSectionModel *section, NSUInteger index, BOOL *stop) {
        [section.cells enumerateObjectsUsingBlock:^(SMAAttrObjectModel *cell, NSUInteger index, BOOL *stop) {
            block(cell, stop);
        }];
    }];
}

@end
