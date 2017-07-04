//
//  SMADictionaryViewController.m
//  SampleApp
//
//  Created by IGavrysh on 6/27/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMADictionaryViewController.h"

static NSString * const kSMADictionaryCellIdentifier = @"SMADictionaryCellIdentifier";

@interface SMADictionaryViewController ()
@property (nonatomic, strong)   NSString                    *sectionTitle;
@property (nonatomic, strong)   NSDictionary                *dictionary;
@property (nonatomic, weak)     IBOutlet UINavigationBar    *navigationBar;
@property (nonatomic, weak)     IBOutlet UITableView        *tableView;

@end

@implementation SMADictionaryViewController

#pragma mark -
#pragma mark Initializatinos and Deallocations

- (instancetype)initWithTitle:(NSString *)sectionTitle dictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.sectionTitle = sectionTitle;
    self.dictionary = dictionary;

    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.topItem.title = self.sectionTitle;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow
                                  animated:YES];

}

- (IBAction)onBackButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                   reuseIdentifier:kSMADictionaryCellIdentifier];
    
    NSArray *keys = [self.dictionary.allKeys sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    id key = keys[indexPath.row];
    id value = self.dictionary[key];
    
    NSString *displayKey = [NSString stringWithFormat:@"%@", key];
    NSString *displayValue = [NSString stringWithFormat:@"%@", value];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        displayValue = @"object";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = displayKey;
    cell.detailTextLabel.text = displayValue;
    
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;

    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *key = selectedCell.textLabel.text;

    id value = self.dictionary[key];
    
    if (![value isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *sectionTitle = [NSString stringWithFormat:@"%@", key];
    NSDictionary *dictionarty = (NSDictionary *)value;
    
    SMADictionaryViewController *controller = [[SMADictionaryViewController alloc] initWithTitle:sectionTitle
                                                                                      dictionary:dictionarty];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
