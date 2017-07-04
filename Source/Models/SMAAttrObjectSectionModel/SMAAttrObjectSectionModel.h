//
//  SMAAttrObjectSectionModel.h
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMAAttrObjectModel;

@interface SMAAttrObjectSectionModel : NSObject <NSCopying>
@property (nonatomic, copy)     NSString                                    *name;
@property (nonatomic, copy)     NSMutableArray<SMAAttrObjectModel *>        *cells;
@property (nonatomic, readonly) NSUInteger                                  count;

+ (instancetype)sectionWithName:(NSString *)name
                         values:(NSArray<SMAAttrObjectModel *> *)values;
+ (instancetype)sectionWithName:(NSString *)name
                     attributes:(NSArray<NSString *> *)attributes;

- (instancetype)initWithName:(NSString *)name
                      values:(NSArray<SMAAttrObjectModel *> *)values;
- (instancetype)initWithName:(NSString *)name
                  attributes:(NSArray<NSString *> *)attributes;

- (SMAAttrObjectModel *)objectAtIndexedSubscript:(NSUInteger)index;


@end
