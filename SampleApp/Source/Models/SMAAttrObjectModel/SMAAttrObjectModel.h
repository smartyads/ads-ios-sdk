//
//  SMAAttrObjectCellModel.h
//  SampleApp
//
//  Created by Ievgen on 4/3/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMAAttrObjectModel : NSObject <NSCopying>
@property (nonatomic, copy)   NSString          *attribute;
@property (nonatomic, copy)   id<NSCopying>     object;

+ (instancetype)cellWithAttribute:(NSString *)attribute;
+ (instancetype)cellWithAttribute:(NSString *)attribute object:(id<NSCopying>)object;

- (instancetype)initWithAttribute:(NSString *)attribute;
- (instancetype)initWithAttribute:(NSString *)attribute object:(id<NSCopying>)object;

@end
