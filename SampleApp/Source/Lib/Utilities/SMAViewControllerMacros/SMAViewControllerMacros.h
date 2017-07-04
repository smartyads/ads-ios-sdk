//
//  SMAViewControllerMacros.h
//  SampleApp
//
//  Created by Ievgen on 3/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#define SMADefineBaseViewProperty(viewClass, propertyName) \
    @property (nonatomic, readonly) viewClass     *propertyName;

#define SMABaseViewGetterSynthesize(viewClass, propertyName) \
    @dynamic propertyName; \
    \
    - (viewClass *)propertyName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define SMAViewControllerBaseViewProperty(viewControllerClass, baseViewClass, propertyName) \
    @interface viewControllerClass (__SMAPrivateBaseView) \
    \
    SMADefineBaseViewProperty(baseViewClass, propertyName); \
    \
    @end \
    \
    @implementation viewControllerClass (__SMAPrivateBaseView) \
    \
    SMABaseViewGetterSynthesize(baseViewClass, propertyName); \
    \
    @end \
