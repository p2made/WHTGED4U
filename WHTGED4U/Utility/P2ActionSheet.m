//
//  P2ActionSheet.m
//  WHTGED4U
//
//  Created by Pedro Plowman on 5/07/13.
//  Copyright (c) 2013 Pedro Plowman. All rights reserved.
//

#import "P2ActionSheet.h"
#import "P2DataModel.h"

@interface P2ActionSheet ()

@property (assign, nonatomic) id<P2ActionSheetDelegate> p2delegate;
@property (strong, nonatomic) NSArray* actionOptions;
@property (strong, nonatomic) NSArray* filterTagsArray;

/*
typedef enum {
	P2SetLikeValue		= 1 << 0,
	P2FilterByLike		= 1 << 1,
	P2FilterByTag		= 1 << 2,
	P2ClearFilter		= 1 << 3,
	P2PostAsTweet		= 1 << 4,
	P2PostToFacebook	= 1 << 5,
} P2ActionOptions;
*/

@end

@implementation P2ActionSheet {
	int _setLikeButtonIndex;
	int _filterByLikeButtonIndex;
	int _filterByTagButtonIndex;
	int _clearFilterButtonIndex;
	int _postAsTweetButtonIndex;
	int _postToFacebookButtonIndex;
}


- (instancetype)initWithDelegate:(id<P2ActionSheetDelegate>)delegate actionOptions:(P2ActionOptions)actionOptions forAchievement:(Achievement*)achievement usingAllTags:(BOOL)usingAllTags
{
	self = [super initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	if (!self) return nil;
	
	_p2delegate = delegate;
	
	_setLikeButtonIndex = [self configureSetLikeValueButtonForState:(actionOptions & P2SetLikeValue) achievement:achievement];
	_filterByLikeButtonIndex = [self configureFilterButtonForState:(actionOptions & P2FilterByLike) clear:NO];
	_filterByTagButtonIndex = [self configureFilterByTagButtonForState:(actionOptions & P2FilterByTag) achievement:achievement usingAllTags:usingAllTags];
	_clearFilterButtonIndex = [self configureFilterButtonForState:(actionOptions & P2ClearFilter) clear:YES];
	
	[self addButtonWithTitle:@"Cancel"];
	[self setCancelButtonIndex:[self numberOfButtons] - 1];
	
	return self;
}

- (int)configureSetLikeValueButtonForState:(BOOL)state achievement:(Achievement*)achievement
{
	if (!state) return -1;
	
	NSString* buttonTitle = [NSString stringWithFormat:@"%@ as Liked", ([achievement likeValue] ? @"Unmark" : @"Mark")];
	[self addButtonWithTitle:buttonTitle];
	return [self numberOfButtons] - 1;
}

- (int)configureFilterButtonForState:(BOOL)state clear:(BOOL)clear
{
	if (!state) return -1;
	
	NSString* buttonTitle = @"Filter to Liked Items";
	if (clear)
		buttonTitle = @"Clear Filter";
	[self addButtonWithTitle:buttonTitle];
	return [self numberOfButtons] - 1;
}

- (int)configureFilterByTagButtonForState:(BOOL)state achievement:(Achievement*)achievement usingAllTags:(BOOL)usingAllTags
{
	if (!state) {
		_filterTagsArray = nil;
		return -1;
	}
	
	if (usingAllTags) {
		_filterTagsArray = [Tag findAllSortedBy:kA_tag ascending:YES];
	} else {
		_filterTagsArray = [achievement tagsArray];
	}
	
	NSString* buttonTitle = @"Filter to Tag...";
	if (1 == [_filterTagsArray count]) {
		Tag* tag = (Tag*)[_filterTagsArray objectAtIndex:0];
		buttonTitle = [NSString stringWithFormat:@"Filter to '%@'", [tag tag]];
	}
	
	[self addButtonWithTitle:buttonTitle];
	return [self numberOfButtons] - 1;
}

- (NSArray*)filterTags
{
	return _filterTagsArray;
}

//- (BOOL)onlyOneTag
//{
//	return (1 == [_filterTagsArray count]);
//}

//- (NSString*)filterTag
//{
//	if (!_filterTagsArray || (1 < [_filterTagsArray count]))
//		return nil;
//	Tag* tag = (Tag*)[_filterTagsArray objectAtIndex:0];
//	return [tag tag];
//}

- (void)actionSheet:(UIActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == _filterByLikeButtonIndex) {
		[_p2delegate selectedFilterByLikeInActionSheet:self];
	} else if (buttonIndex == _filterByTagButtonIndex) {
		[_p2delegate selectedFilterByTagInActionSheet:self];
	} else if (buttonIndex == _clearFilterButtonIndex) {
		[_p2delegate selectedClearFilterInActionSheet:self];
	} else if (buttonIndex == _setLikeButtonIndex) {
		if ([_p2delegate respondsToSelector:@selector(selectedSetLikeValueInActionSheet:)])
			[_p2delegate selectedSetLikeValueInActionSheet:self];
//	} else if (buttonIndex == _postAsTweetButtonIndex) {
//		if ([_p2delegate respondsToSelector:@selector(selectedPostAsTweetInActionSheet:)])
//			[_p2delegate selectedPostAsTweetInActionSheet:self];
//	} else if (buttonIndex == _postToFacebookButtonIndex) {
//		if ([_p2delegate respondsToSelector:@selector(selectedPostToFacebookInActionSheet:)])
//			[_p2delegate selectedPostToFacebookInActionSheet:self];
	} else {
		if ([_p2delegate respondsToSelector:@selector(selectedCancelInActionSheet:)])
			[_p2delegate selectedCancelInActionSheet:self];
	}
}

@end
