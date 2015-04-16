//
//  P2ListViewController.m
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2ListViewController.h"
#import "P2AchievementsDataset.h"
#import "P2ScrollViewController.h"
#import "P2DataModel.h"
#import "MBProgressHUD.h"

@interface P2ListViewController ()

@property (strong, nonatomic) P2AchievementsDataset* dataset;
@property (strong, nonatomic) NSArray* filterTagsArray;

@end

@implementation P2ListViewController {
	MBProgressHUD* _hud;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSString* lastUpdate = [[NSUserDefaults standardUserDefaults] stringForKey:kLastUpdate];
	BOOL usingHUD = NO;
	if (!lastUpdate) {
		NSLog(@"First time!!!");
		UIView* theView = [[self navigationController] view];
		_hud = [[MBProgressHUD alloc] initWithView:theView];
		[theView addSubview:_hud];
		[_hud setMode:MBProgressHUDModeIndeterminate];
		[_hud setDimBackground:YES];
		[_hud setLabelText:@"fetching data"];
		[_hud show:YES];
		usingHUD = YES;
	}
	
	P2DataSynchroniser* synchroniser = [[P2DataSynchroniser alloc] initWithDelegate:self usingHUD:usingHUD];
	[synchroniser synchronise];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	_dataset = [P2AchievementsDataset shared];
	[[self tableView] reloadData];
}

#pragma mark - IBActions

- (IBAction)tappedSearchButton:(id)sender
{
	P2ActionOptions actionOptions = P2FilterByLike | P2FilterByTag;
	if ([_dataset filterState] != P2Unfiltered)
		actionOptions |= P2ClearFilter;
	
	P2ActionSheet* actionSheet = [[P2ActionSheet alloc] initWithDelegate:self actionOptions:actionOptions forAchievement:nil usingAllTags:YES];
	[actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_dataset count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
	Achievement* cellAchievement = [_dataset objectAtIndex:[indexPath row]];
	[[cell textLabel] setText:[cellAchievement what]];
	[[cell detailTextLabel] setText:[cellAchievement tagsList]];
	[[cell imageView] setImage:[cellAchievement likeImageInList:YES]];
}

#pragma mark - P2ActionSheetDelegate

- (void)selectedFilterByLikeInActionSheet:(P2ActionSheet*)actionSheet
{
	NSLog(@"selectedFilterByLike");
	[self applyFilterForState:P2FilteredByLike withTag:nil];
}

- (void)selectedFilterByTagInActionSheet:(P2ActionSheet*)actionSheet
{
	NSLog(@"selectedFilterByTag");
	_filterTagsArray = [actionSheet filterTags];
	if (1 == [_filterTagsArray count]) {
		Tag* tag = (Tag*)[_filterTagsArray objectAtIndex:0];
		[self applyFilterForState:P2FilteredByTag withTag:[tag tag]];
		return;
	}
	
	P2PickerAlertView* pickerAlert = [[P2PickerAlertView alloc] initWithTitle:@"Select a tag..." dataSource:self delegate:self];
	[pickerAlert show];
}

- (void)selectedClearFilterInActionSheet:(P2ActionSheet*)actionSheet
{
	NSLog(@"selectedClearFilter");
	[self applyFilterForState:P2Unfiltered withTag:Nil];
}

#pragma mark - P2PickerAlertViewDataSource

- (NSInteger)numberOfComponentsInPickerAlert:(P2PickerAlertView*)pickerAlert
{
	return 1;
}
- (NSInteger)pickerAlert:(P2PickerAlertView*)pickerAlert numberOfRowsInComponent:(NSInteger)component
{
	return [_filterTagsArray count];
}

#pragma mark - P2PickerAlertViewDelegate

- (void)pickerAlert:(P2PickerAlertView*)pickerAlert didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == [pickerAlert cancelButtonIndex]) {
		NSLog(@"pickerAlert cancelled");
		return;
	}
	
	NSLog(@"pickerSelection: %@", [pickerAlert pickerSelection]);
	[self applyFilterForState:P2FilteredByTag withTag:[pickerAlert pickerSelection]];
	_filterTagsArray = nil;
}

- (NSString*)pickerAlert:(P2PickerAlertView*)pickerAlert titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	Tag* tag = (Tag*)[_filterTagsArray objectAtIndex:row];
	return [tag tag];
}

#pragma mark - Synchronisation

- (void)synchronisationFailed
{
	if (_hud) [self removeHUD];
	
	NSString* title = @"Connection Failed";
	NSString* message = @"WHTGED4U couldn't get data. Check your internet connection before running WHTGED4U again.";
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
}

- (void)synchronisationCompleted
{
	if (_hud) [self removeHUD];
	
	[self applyFilterForState:P2Unfiltered withTag:nil];
}

- (void)removeHUD
{
	[_hud hide:YES];
	[_hud removeFromSuperview];
	_hud = nil;
}

#pragma mark - utility

- (void)applyFilterForState:(P2FilterState)filterState withTag:(NSString*)filterTag
{
	[_dataset fetchDataForFilterState:filterState withTag:filterTag];
	[[self tableView] reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
	if (![[segue identifier] isEqualToString:@"showDetail"])
		return;
	
	NSIndexPath* indexPath = [[self tableView] indexPathForSelectedRow];
	[[segue destinationViewController] setCurrentIndex:[indexPath row]];
}

@end
