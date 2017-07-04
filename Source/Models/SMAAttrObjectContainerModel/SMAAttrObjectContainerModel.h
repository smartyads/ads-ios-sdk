//
//  SMAAttrObjectTableViewModel.h
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMAAttrObjectSectionModel;
@class SMAAttrObjectCellModel;

@interface SMAAttrObjectContainerModel : NSObject
@property (nonatomic, copy)     NSMutableArray<SMAAttrObjectSectionModel *>     *sections;
@property (nonatomic, readonly) NSUInteger                                      count;

+ (instancetype)modelWithSections:(NSArray<SMAAttrObjectSectionModel *> *)sections;

- (instancetype)initWithSections:(NSArray<SMAAttrObjectSectionModel *> *)sections;

- (void)addSectionWithName:(NSString *)name
                    values:(NSArray<SMAAttrObjectCellModel *> *)values;

- (SMAAttrObjectSectionModel *)objectAtIndexedSubscript:(NSUInteger)index;

- (void)setObject:(id<NSCopying>)object forKeyedSubscript:(NSString *)key;

- (id)objectForKeyedSubscript:(NSString *)key;

@end
