//
//  P2ActionSheet.h
//  WHTGED4U
//
//  Created by Pedro Plowman on 5/07/13.
//  Copyright (c) 2013 Pedro Plowman. All rights reserved.
//

@protocol P2ActionSheetDelegate;

typedef enum {
	P2SetLikeValue		= 1 << 0,
	P2FilterByLike		= 1 << 1,
	P2FilterByTag		= 1 << 2,
	P2ClearFilter		= 1 << 3,
	P2PostAsTweet		= 1 << 4,
	P2PostToFacebook	= 1 << 5,
} P2ActionOptions;

@class Achievement;

@interface P2ActionSheet : UIActionSheet <UIActionSheetDelegate>

- (instancetype)initWithDelegate:(id<P2ActionSheetDelegate>)delegate actionOptions:(P2ActionOptions)actionOptions forAchievement:(Achievement*)achievement usingAllTags:(BOOL)usingAllTags;

- (NSArray*)filterTags;

@end

@protocol P2ActionSheetDelegate <NSObject>

- (void)selectedFilterByLikeInActionSheet:(P2ActionSheet*)actionSheet;
- (void)selectedFilterByTagInActionSheet:(P2ActionSheet*)actionSheet;
- (void)selectedClearFilterInActionSheet:(P2ActionSheet*)actionSheet;

@optional

- (void)selectedSetLikeValueInActionSheet:(P2ActionSheet*)actionSheet;
- (void)selectedPostAsTweetInActionSheet:(P2ActionSheet*)actionSheet;
- (void)selectedPostToFacebookInActionSheet:(P2ActionSheet*)actionSheet;
- (void)selectedCancelInActionSheet:(P2ActionSheet*)actionSheet;

@end
