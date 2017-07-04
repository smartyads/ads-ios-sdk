//
//  SMASampleAppGeneral.h
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline NSString *sma_stringWithBool(BOOL value) {
    return value ? @"YES" : @"NO";
}

extern
CGRect sma_rectWithSizeCenteredInRect(CGSize size, CGRect rect);

@interface SMASampleAppGeneral : NSObject

@end
