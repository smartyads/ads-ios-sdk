//
//  SMAAdContainerViewController.m
//  SampleApp
//
//  Created by Ievgen on 4/19/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import <SmartyAdsSDK/SmartyAdsSDK.h>
#import <WebKit/WebKit.h>

#import "SMAAdPresentationViewController.h"

#import "SMAAdPresentationView.h"
#import "SMAAttrObjectModel.h"
#import "SMAAttrObjectSectionModel.h"
#import "SMAAttrObjectContainerModel.h"

#import "SMASampleAppGeneral.h"
#import "SMADictionaryViewController.h"

#import "SMAViewControllerMacros.h"

@interface SMAAdPresentationViewController () <
    UIPickerViewDelegate,
    UIPickerViewDataSource,
    MFMailComposeViewControllerDelegate
>
@property (strong, nonatomic)   NSTimer             *timer;

@end

SMAViewControllerBaseViewProperty(SMAAdPresentationViewController, SMAAdPresentationView, adPresentationView)

@implementation SMAAdPresentationViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.adPresentationView reloadAdViewForPickerValueChange];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.adPresentationView setRandomBackgroundColor];
    
    [self.adPresentationView initModels];
    
    self.adPresentationView.adTypePickerView.dataSource = self;
    self.adPresentationView.adTypePickerView.delegate = self;
    
    [self.adPresentationView addInformationLabel];
}

#pragma mark -
#pragma mark View Actions

- (IBAction)onAutorefreshSwitchValueChange:(UISwitch *)switchControl {
    [self.adPresentationView reloadAdViewForSwitchAutorefreshChange];
}

- (IBAction)onAutorefreshClick:(id)sender {
    self.adPresentationView.autorefreshSwtich.on = !self.adPresentationView.autorefreshSwtich.on;
    [self onAutorefreshSwitchValueChange:self.adPresentationView.autorefreshSwtich];
}

- (IBAction)onSendLogClicked:(id)sender {
    SMALoggingMailViewController *controller = [SMALoggingMailViewController controllerWithDelegate:self];
    
    if (controller) {
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSString *title = @"Cannot sent issue report";
        NSString *message = @"Sorry, your issue can't be reported right now. This is most likely because no mail accounts are set up on your mobile device";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                            preferredStyle:UIAlertControllerStyleAlert];
        [self showViewController:alertController sender:self];
    }
}

- (IBAction)onSettingsClicked:(id)sender {
    NSDictionary *dictionary = [self.adPresentationView.bannerAdView adConsumerInfo];
    SMADictionaryViewController *adConsumerInfoController = [[SMADictionaryViewController alloc] initWithTitle:@"Consumer Info" dictionary:dictionary];
    
    [self presentViewController:adConsumerInfoController animated:YES completion:nil];
}

- (IBAction)onLoadClicked:(id)sender {
    [self.adPresentationView loadAd];
}

- (IBAction)onCancelClicked:(id)sender {
    [self.adPresentationView cancelLoad];
}

- (IBAction)onStepperValueChanged:(UIStepper *)sender {
    [self.adPresentationView autorefreshValueChange];
}

#pragma mark -
#pragma mark  UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    [self.adPresentationView reloadAdViewForPickerValueChange];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.adPresentationView.pickerModel.sections.count;
}

- (NSInteger)   pickerView:(UIPickerView *)pickerView
   numberOfRowsInComponent:(NSInteger)component
{
    return self.adPresentationView.pickerModel.sections[component].count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component
{
    return [self.adPresentationView attributedTitleForPickerAtComponent:component row:row];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
