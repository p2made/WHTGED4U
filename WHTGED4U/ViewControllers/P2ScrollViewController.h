//
//  P2ScrollViewController.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2ActionSheet.h"
#import "P2PickerAlertView.h"

@class P2AchievementsDataset;
@class P2WebViewController;
@class Achievement;
@class Tag;

@interface P2ScrollViewController : UIViewController <P2ActionSheetDelegate, P2PickerAlertViewDataSource, P2PickerAlertViewDelegate>

@property (strong, nonatomic) P2WebViewController* webViewController;

@property (weak, nonatomic) IBOutlet UILabel* whatLabel;
@property (weak, nonatomic) IBOutlet UITextView* benefitText;
@property (weak, nonatomic) IBOutlet UIButton* likeImageButton;
@property (weak, nonatomic) IBOutlet UIButton* tagsTextButton;
@property (weak, nonatomic) IBOutlet UIToolbar* toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* playPauseButton;

- (void)setCurrentIndex:(NSUInteger)newIndex;

- (IBAction)tappedSearchButton:(id)sender;
- (IBAction)tappedScrollNextButton:(id)sender;
- (IBAction)tappedScrollPreviousButton:(id)sender;
- (IBAction)tappedPlayPauseButton:(id)sender;
- (IBAction)tappedLikeImageButton:(id)sender;
- (IBAction)tappedTagsTextButton:(id)sender;
- (IBAction)tappedActionButton:(id)sender;

@end
