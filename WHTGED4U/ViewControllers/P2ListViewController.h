//
//  P2ListViewController.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2ActionSheet.h"
#import "P2PickerAlertView.h"
#import "P2DataSynchroniser.h"

@class P2ScrollViewController;

@interface P2ListViewController : UITableViewController <P2DataSynchroniserDelegate, P2ActionSheetDelegate, P2PickerAlertViewDataSource, P2PickerAlertViewDelegate>

@property (strong, nonatomic) P2ScrollViewController* scrollViewController;

- (IBAction)tappedSearchButton:(id)sender;

@end
