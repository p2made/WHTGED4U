//
//  P2ScrollViewController.m
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2ScrollViewController.h"
#import "P2AchievementsDataset.h"
#import "P2WebViewController.h"
#import "P2DataModel.h"
#import "UITextView+Size.h"

#define kScrollInterval 5.0

@interface P2ScrollViewController ()

@property (strong, nonatomic) P2AchievementsDataset* dataset;
@property (strong, nonatomic) NSTimer* autoScrollTimer;
@property (readonly, nonatomic) BOOL useAllTagsForFilter;
@property (strong, nonatomic) NSArray* filterTagsArray;
@property (strong, nonatomic) NSString* selectedFilterTag;

@end

typedef enum {
	P2AutoScrollingOff,
	P2AutoScrollingOn,
	P2AutoScrollingPaused
} P2AutoScrollingState;

NSString *const kBarItemPause =	@"bar-item-pause";
NSString *const kBarItemPlay =	@"bar-item-play";

@implementation P2ScrollViewController

NSUInteger _currentIndex;
P2AutoScrollingState autoScrollingState = P2AutoScrollingOff;

#pragma mark - Managing the detail item

- (void)setCurrentIndex:(NSUInteger)newIndex
{
	_dataset = [P2AchievementsDataset shared];
	_currentIndex = newIndex;
}

- (void)viewDidLoad
{
	autoScrollingState = [self autoScrollingOn];
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self configureView];
	[super viewDidAppear:animated];
}

- (void)configureView
{
	Achievement* achievementItem = [self currentAchievement];
	if (!achievementItem) return;
	
	[_whatLabel setText:[achievementItem what]];
	[_benefitText setText:[achievementItem benefit]];
	[_benefitText setFontSizeToFit];
	[_likeImageButton setImage:[achievementItem likeImageInList:NO] forState:UIControlStateNormal];
	BOOL hasTags = [achievementItem hasTags];
	[_tagsTextButton setEnabled:hasTags];
	[_tagsTextButton setHidden:!hasTags];
	[_tagsTextButton setTitle:(hasTags ? [achievementItem tagsList] : @"") forState:UIControlStateNormal];
}

#pragma mark - IBActions

- (IBAction)tappedSearchButton:(id)sender
{
	_useAllTagsForFilter = YES;
	P2ActionOptions actionOptions = P2FilterByLike | P2FilterByTag;
	[self showActionSheetWithOptions:actionOptions usingAllTags:YES];
}

- (IBAction)tappedScrollNextButton:(id)sender
{
	[self scrollNext:nil];
}

- (IBAction)tappedScrollPreviousButton:(id)sender
{
	[self scrollPrevious];
}

- (IBAction)tappedPlayPauseButton:(id)sender
{
	[self toggleAutoScrolling];
}

- (IBAction)tappedLikeImageButton:(id)sender
{
	P2ActionOptions actionOptions = P2SetLikeValue | P2FilterByLike;
	[self showActionSheetWithOptions:actionOptions usingAllTags:NO];
}

- (IBAction)tappedTagsTextButton:(id)sender
{
	P2ActionOptions actionOptions = P2FilterByTag;
	[self showActionSheetWithOptions:actionOptions usingAllTags:NO];
}

- (IBAction)tappedActionButton:(id)sender
{
	P2ActionOptions actionOptions = P2SetLikeValue | P2FilterByLike | P2FilterByTag;
	[self showActionSheetWithOptions:actionOptions usingAllTags:NO];
}

#pragma mark - Action Sheet

- (void)showActionSheetWithOptions:(P2ActionOptions)options usingAllTags:(BOOL)usingAllTags
{
	[self pauseAutoScrolling];
	if ([_dataset filterState] != P2Unfiltered)
		options |= P2ClearFilter;
	
	P2ActionSheet* actionSheet = [[P2ActionSheet alloc] initWithDelegate:self actionOptions:options forAchievement:[self currentAchievement] usingAllTags:usingAllTags];
	[actionSheet showFromToolbar:_toolbar];
}

#pragma mark - scrolling control

- (void)scrollPrevious
{
	_currentIndex = (_currentIndex != 0 ? --_currentIndex : [_dataset count] - 1);
	[self configureView];
}

- (void)scrollNext:(NSTimer*)timer
{
	_currentIndex = (_currentIndex + 1 != [_dataset count] ? ++_currentIndex : 0);
	[self configureView];
}

- (void)toggleAutoScrolling
{
	if (P2AutoScrollingOn == autoScrollingState)
		autoScrollingState = [self autoScrollingOff];
	else
		autoScrollingState = [self autoScrollingOn];
}

- (BOOL)autoScrollingOn
{
	_autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:(kScrollInterval) target:self selector:@selector(scrollNext:)
													  userInfo:nil repeats:YES];
	[_playPauseButton setImage:[UIImage imageNamed:kBarItemPause]];
	return P2AutoScrollingOn;
}

- (BOOL)autoScrollingOff
{
	[_autoScrollTimer invalidate]; _autoScrollTimer = nil;
	[_playPauseButton setImage:[UIImage imageNamed:kBarItemPlay]];
	return P2AutoScrollingOff;
}

- (void)pauseAutoScrolling
{
	if (P2AutoScrollingOn != autoScrollingState)
		return;
	[self toggleAutoScrolling];
	autoScrollingState = P2AutoScrollingPaused;
}

- (void)resumeAutoScrolling
{
	if (P2AutoScrollingPaused != autoScrollingState)
		return;
	[self toggleAutoScrolling];
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

- (void)selectedSetLikeValueInActionSheet:(P2ActionSheet*)actionSheet
{
	NSLog(@"selectedSetLikeValue");
	[self resumeAutoScrolling];
	NSString* reference = [[self currentAchievement] reference];
	__block Achievement* achievementItem;
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		achievementItem = [Achievement findFirstByAttribute:kA_reference withValue:reference inContext:localContext];
		if (achievementItem)
			[achievementItem setLikeValue:![achievementItem likeValue]];
	} completion:^(BOOL success, NSError *error) {
		[_likeImageButton setImage:[achievementItem likeImageInList:NO] forState:UIControlStateNormal];
	}];
}

- (void)selectedCancelInActionSheet:(P2ActionSheet*)actionSheet
{
	[self resumeAutoScrolling];
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

- (void)pickerAlertCancel:(P2PickerAlertView*)pickerAlert
{
	NSLog(@"pickerAlert cancelled");
	[self resumeAutoScrolling];
}

- (NSString*)pickerAlert:(P2PickerAlertView*)pickerAlert titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	Tag* tag = (Tag*)[_filterTagsArray objectAtIndex:row];
	return [tag tag];
}

#pragma mark - utility

- (void)applyFilterForState:(P2FilterState)filterState withTag:(NSString*)filterTag
{
	[self resumeAutoScrolling];
	[_dataset fetchDataForFilterState:filterState withTag:filterTag];
	_currentIndex = 0;
	[self configureView];
}

- (Achievement*)currentAchievement
{
	return [_dataset objectAtIndex:_currentIndex];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
	if (![[segue identifier] isEqualToString:@"showMoreInfo"])
		return;
	
	NSString* urlString = [[self currentAchievement] url];
	[[segue destinationViewController] setInfoURLWithString:urlString];
}

@end
