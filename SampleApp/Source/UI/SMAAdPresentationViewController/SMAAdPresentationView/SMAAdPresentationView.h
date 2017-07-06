//
//  SMAAdContainerView.h
//  SampleApp
//
//  Created by IGavrysh on 5/11/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SmartyAdsSDK/SmartyAdsSDK.h>

typedef void * (^SMAPickerViewChangeAction) ();
typedef void * (^SMASegmentedControlValueChangeAction) ();

@class SMAAdView;
@class SMAAttrObjectContainerModel;

@interface SMAAdPresentationView : UIView
@property (nonatomic, strong)   SMABannerAdView                             *bannerAdView;
@property (nonatomic, strong)   IBOutlet UIView                             *contentView;
@property (nonatomic, strong)   IBOutlet UIPickerView                       *adTypePickerView;
@property (nonatomic, strong)   IBOutlet UISwitch                           *autorefreshSwtich;
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView            *spinner;
@property (nonatomic, strong)   IBOutlet UITextView                         *logTextView;
@property (nonatomic, strong)   IBOutlet UIButton                    *autorefreshButton;
@property (nonatomic, strong)   IBOutlet UIBarButtonItem                    *autorefreshInfo;
@property (nonatomic, strong)   IBOutlet UIStepper                          *autorefreshStepper;
@property (nonatomic, assign, readonly, getter=isAutoRefresh) BOOL          autoRefresh;
@property (nonatomic, strong)   SMAAttrObjectContainerModel                 *pickerModel;

- (void)setRandomBackgroundColor;

- (void)initModels;

- (NSAttributedString *)attributedTitleForPickerAtComponent:(NSInteger)component
                                                        row:(NSInteger)row;

- (void)reloadAdViewForPickerValueChange;

- (void)reloadAdViewForSwitchAutorefreshChange;

- (void)autorefreshValueChange;

- (void)addInformationLabel;

- (void)loadAd;

- (void)cancelLoad;

@end
