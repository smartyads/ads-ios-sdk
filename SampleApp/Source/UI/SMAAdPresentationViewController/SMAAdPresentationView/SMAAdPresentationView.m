//
//  SMAAdPresentationView.m
//  SampleApp
//
//  Created by IGavrysh on 5/11/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

//#import "SMAGlobal.h"

#import "SMAAdPresentationView.h"

#import "SMAAttrObjectModel.h"
#import "SMAAttrObjectSectionModel.h"
#import "SMAAttrObjectContainerModel.h"

#import "UIColor+SMAExtensions.h"

static NSString * const kSMAAdContainerTypeComponent = @"Smarty Ads Cntainer Types";
static NSString * const kSMAStandardBanner = @"Standard Banner";
static NSString * const kSMALargeBanner = @"Large Banner";
static NSString * const kSMAIABMediumRectangle = @"IAB Medium Rectangle";
static NSString * const kSMAIABFullSizeBanner = @"IAB Full Size Banner";
static NSString * const kSMAIABLeaderBoard = @"IAB Leader Board";

static NSString * const kSMASourceTypeComponent = @"Ad Source";
static NSString * const kSMABaseURLSourceSmartyAds = @"SmartyAds";
static NSString * const kSMABaseURLSourceCarousel = @"Carousel";

static NSString * const kSMABehaviourTypeComponent = @"Behaviour Type";      // AutoRefresh or Static
static NSString * const kSMABehaviourTypeStatic = @"Static";
static NSString * const kSMABehavioutTypeAutorefresh = @"Autorefresh";

@interface SMAAdPresentationView () <SMABannerAdViewDelegate>
@property (nonatomic, assign, readonly, getter=isDarkBackground)    BOOL        darkBackground;
@property (nonatomic, strong)   NSString    *infoText;
@property (nonatomic, strong)   UILabel     *infoLabel;
@property (nonatomic, strong)   NSTimer     *autorefreshWaitTimer;

@end

@implementation SMAAdPresentationView

@dynamic darkBackground;
@dynamic autoRefresh;
@dynamic infoText;

#pragma mark -
#pragma mark Initializations and Dealloactions

- (void)initModels {
    NSArray *sections
    = @[[SMAAttrObjectSectionModel  sectionWithName:kSMAAdContainerTypeComponent
                                         attributes:@[kSMAStandardBanner,
                                                      kSMALargeBanner,
                                                      kSMAIABMediumRectangle,
                                                      kSMAIABFullSizeBanner,
                                                      kSMAIABLeaderBoard
                                                      ]
         ]];
    
    self.pickerModel = [SMAAttrObjectContainerModel modelWithSections:sections];
    
    __weak typeof (self) weakSelf = self;
    
    self.pickerModel[kSMAStandardBanner] = ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        [strongSelf _updateAdViewWithSize:kSMAAdSizeBanner placementId:@"3729"];
    };
    
    self.pickerModel[kSMALargeBanner] = ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        [strongSelf _updateAdViewWithSize:kSMAAdSizeLargeBanner placementId:@"3730"];
    };
    
    self.pickerModel[kSMAIABMediumRectangle] = ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        [strongSelf _updateAdViewWithSize:kSMAAdSizeIABMediumRectangle placementId:@"3358"];
    };
    
    self.pickerModel[kSMAIABFullSizeBanner] = ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        [strongSelf _updateAdViewWithSize:kSMAAdSizeIABFullSizeBanner placementId:@"4405"];
    };
    
    self.pickerModel[kSMAIABLeaderBoard] = ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        [strongSelf _updateAdViewWithSize:kSMAAdSizeIABLeaderBoard placementId:@"3732"];
    };
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isDarkBackground {
    return [self.contentView.backgroundColor brightness] > 0.2;
}

- (BOOL)isAutoRefresh {
    return self.autorefreshSwtich.on;
}

- (void)setInfoText:(NSString *)infoText {
    self.infoLabel.text = infoText;
    
    [self.infoLabel sizeToFit];
}

- (NSString *)infoText {
    return self.infoLabel.text;
}

#pragma mark -
#pragma mark Public Methods

- (void)setRandomBackgroundColor {
    self.backgroundColor = [UIColor randomColor];
}

- (NSAttributedString *)attributedTitleForPickerAtComponent:(NSInteger)component
                                                        row:(NSInteger)row
{
    UIColor *titleTextColor = self.isDarkBackground ? [UIColor whiteColor] : [UIColor blackColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: titleTextColor};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Not Found"
                                                                              attributes:attributes];
    
    SMAAttrObjectModel *model = self.pickerModel[component][row];
    
    if (![model isEqual:[NSNull null]]) {
        [title replaceCharactersInRange:NSMakeRange(0, title.string.length) withString:model.attribute];
    }
    
    return title;
}

- (void)reloadAdViewForSwitchAutorefreshChange {
    [self reloadAdViewForPickerValueChange];
}

- (void)reloadAdViewForPickerValueChange {
    NSInteger component = 0;
    NSInteger row = [self.adTypePickerView selectedRowInComponent:component];
    
    NSString *title = [[self.adTypePickerView.delegate pickerView:self.adTypePickerView
                                            attributedTitleForRow:row
                                                     forComponent:component] string];
    
    id object = self.pickerModel[title];
    
    if (![object isEqual:[NSNull null]]) {
        ((SMAPickerViewChangeAction)object)();
    }
    
    [self stopWaitTimerUntilDate];
}

- (void)addInformationLabel {
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.infoLabel];
}

- (void)autorefreshValueChange {
    self.autorefreshSwtich.on = YES;
    
    [self reloadAdViewForPickerValueChange];
}

#pragma mark - 
#pragma mark Private methods

- (void)_updateAdViewWithSize:(CGSize)size placementId:(NSString *)placementId {
    if (self.bannerAdView) {
        [self.bannerAdView removeFromSuperview];
        
        self.bannerAdView = nil;
    }
    
    self.bannerAdView = [[SMABannerAdView alloc] initWithPlacementId:placementId size:size];
    if (!self.isAutoRefresh) {
        self.bannerAdView.autoRefreshInterval = 0.0f;
    } else {
        self.bannerAdView.autoRefreshInterval = self.autorefreshStepper.value;
    }
    
    self.bannerAdView.delegate = self;

    [self.bannerAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addSubview:self.bannerAdView];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.0
                                                                 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:size.width]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:size.height]];
    
    [self layoutIfNeeded];
    
    [self.bannerAdView load];
}

- (void)addCoverForView:(UIView *)view {
    CGRect frame = view.frame;
    
    CGRect coverRectView = CGRectMake(frame.origin.x - 1,
                                      frame.origin.y - 1,
                                      frame.origin.x + frame.size.width + 1,
                                      frame.origin.y + frame.size.height + 1);
    
    UIView *coverView = [[UIView alloc] initWithFrame:coverRectView];
    
    coverView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:coverView];
}

- (void)runWaitTimerUntilDate:(NSDate *)date {
    if (!self.autorefreshWaitTimer) {
        [self.autorefreshWaitTimer invalidate];
        
        self.autorefreshWaitTimer = nil;
    }
    
    self.autorefreshWaitTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                 target:self
                                                               selector:@selector(progressChange)
                                                               userInfo:date
                                                                repeats:YES];
}

- (void)stopWaitTimerUntilDate {
    [self.autorefreshWaitTimer invalidate];
    self.autorefreshWaitTimer = nil;
    self.autorefreshInfo.title = @"";
}

- (void)progressChange {
    NSDate *expirationDate = self.autorefreshWaitTimer.userInfo;
    NSTimeInterval secondsToExpiration = [expirationDate timeIntervalSinceDate:[NSDate date]];
    if (secondsToExpiration < 0) {
        secondsToExpiration = 0;
    }
    
    self.autorefreshInfo.title = [NSString stringWithFormat:@"↺ in %.0fs", secondsToExpiration];
    
    if (secondsToExpiration == 0) {
        [self stopWaitTimerUntilDate];
    }
}

- (void)loadFinished {
    [self.spinner stopAnimating];
    
    NSTimeInterval autorefreshTimeInterval = self.bannerAdView.autoRefreshInterval;
    if (autorefreshTimeInterval > 0) {
        [self runWaitTimerUntilDate:[NSDate dateWithTimeIntervalSinceNow:autorefreshTimeInterval]];
    }
}

- (void)loadAd {
    [self.bannerAdView forceRefreshAd];
}

- (void)cancelLoad {
    [self.bannerAdView cancelLoad];
    
    [self stopWaitTimerUntilDate];
}


#pragma mark -
#pragma mark SMABannerAdViewDelegate

- (void)adViewWillLoad:(SMABannerAdView *)adView {
    [self.spinner startAnimating];
}

- (void)adViewDidLoad:(SMABannerAdView *)adView {
    [self setNeedsDisplay];
    
    [self loadFinished];
}

- (void)adView:(SMABannerAdView *)adView didFailLoadingWithError:(NSError *)error {
    NSString *message = [NSString stringWithFormat:@"[Sample App] Ad container failed with %@", error];
    
    NSLog(@"%@", message);
    
    self.logTextView.text = [self.logTextView.text stringByAppendingFormat:@"%@\n", message];
    
    [self loadFinished];
}

- (BOOL)shouldRequestPreciseLocation {
    return YES;
}

- (BOOL)shouldCheckAdLinks {
    return NO;
}

@end
