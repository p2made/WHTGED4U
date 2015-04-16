//
//  P2PickerAlertView.h
//  P2PickerAlertView
//
//  Created by Pedro Plowman on 11/08/13.
//  Copyright (c) 2013 P2. All rights reserved.
//

#define kPickerCornerRadius 5.

@protocol P2PickerAlertViewDataSource;
@protocol P2PickerAlertViewDelegate;

@interface P2PickerAlertView : UIAlertView <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSString* pickerSelection;

- (instancetype)initWithTitle:(NSString*)title dataSource:(id<P2PickerAlertViewDataSource>)dataSource delegate:(id<P2PickerAlertViewDelegate>)delegate;

@end

@protocol P2PickerAlertViewDataSource <NSObject>

- (NSInteger)numberOfComponentsInPickerAlert:(P2PickerAlertView*)pickerAlert;
- (NSInteger)pickerAlert:(P2PickerAlertView*)pickerAlert numberOfRowsInComponent:(NSInteger)component;

@end

@protocol P2PickerAlertViewDelegate <NSObject>

@optional

//- (void)pickerAlert:(P2PickerAlertView*)pickerAlert clickedButtonAtIndex:(NSInteger)buttonIndex;

//- (void)willPresentPickerAlert:(P2PickerAlertView*)pickerAlert;
//- (void)didPresentPickerAlert:(P2PickerAlertView*)pickerAlert;

- (void)pickerAlert:(P2PickerAlertView*)pickerAlert willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)pickerAlert:(P2PickerAlertView*)pickerAlert didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)pickerAlertCancel:(P2PickerAlertView*)pickerAlert;

//- (BOOL)pickerAlertShouldEnableFirstOtherButton:(P2PickerAlertView*)pickerAlert;

- (void)pickerAlert:(P2PickerAlertView*)pickerAlert didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
//- (void)pickerAlert:(P2PickerAlertView*)pickerAlert didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

- (NSString*)pickerAlert:(P2PickerAlertView*)pickerAlert titleForRow:(NSInteger)row forComponent:(NSInteger)component;
//- (NSAttributedString*)pickerAlert:(P2PickerAlertView*)pickerAlert attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
//- (UIView*)pickerAlert:(P2PickerAlertView*)pickerAlert viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView*)view;

//- (CGFloat)pickerAlert:(P2PickerAlertView*)pickerAlert rowHeightForComponent:(NSInteger)component;
//- (CGFloat)pickerAlert:(P2PickerAlertView*)pickerAlert widthForComponent:(NSInteger)component;

@end
