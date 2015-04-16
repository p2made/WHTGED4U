//
//  P2PickerAlertView.m
//  P2PickerAlertView
//
//  Created by Pedro Plowman on 11/08/13.
//  Copyright (c) 2013 P2. All rights reserved.
//

#import "P2PickerAlertView.h"

@interface P2PickerAlertView ()

@property (nonatomic, assign) BOOL presented;

@property (assign, nonatomic) id<P2PickerAlertViewDataSource> dataSource;
@property (assign, nonatomic) id<P2PickerAlertViewDelegate> pickerDelegate;
@property (strong, nonatomic) UIAlertView* alertView;
@property (strong, nonatomic) UIPickerView* pickerView;
@property (strong, nonatomic) NSArray* pickerItems;

@end

@implementation P2PickerAlertView

- (instancetype)initWithTitle:(NSString*)title dataSource:(id<P2PickerAlertViewDataSource>)dataSource delegate:(id<P2PickerAlertViewDelegate>)delegate
{
	self = [super initWithTitle:title message:@"\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Select", nil];
	if (!self) return nil;
	
	_dataSource = dataSource;
	_pickerDelegate = delegate;
	
	_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(6, 44, 272, 162)];
	[_pickerView setDelegate:self];
	[_pickerView setDataSource:self];
	[_pickerView setShowsSelectionIndicator:YES];
	[_pickerView setOpaque:NO];
	_pickerSelection = [self pickerView:_pickerView titleForRow:0 forComponent:0];
//	[_pickerView selectRow:1 inComponent:0 animated:NO];
	
	UILabel* message = [[self subviews] objectAtIndex:1];
	[message setFont:[UIFont systemFontOfSize:15]];
	[self addSubview:_pickerView];
	
	return self;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	return [_dataSource numberOfComponentsInPickerAlert:self];
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	return [_dataSource pickerAlert:self numberOfRowsInComponent:component];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	_pickerSelection = [self pickerView:pickerView titleForRow:row forComponent:component];
	if ([_pickerDelegate respondsToSelector:@selector(pickerAlert:didSelectRow:inComponent:)])
		[_pickerDelegate pickerAlert:self didSelectRow:row inComponent:component];
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	if (![_pickerDelegate respondsToSelector:@selector(pickerAlert:titleForRow:forComponent:)])
		return nil;
	return [_pickerDelegate pickerAlert:self titleForRow:row forComponent:component];
}

//- (NSAttributedString*)pickerView:(UIPickerView*)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//	if (![_pickerDelegate respondsToSelector:@selector(pickerAlert:attributedTitleForRow:forComponent:)])
//		return nil;
//	return [_pickerDelegate pickerAlert:self attributedTitleForRow:row forComponent:component];
//}
//
//- (UIView*)pickerView:(UIPickerView*)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView*)view
//{
//	if (![_pickerDelegate respondsToSelector:@selector(pickerAlert:viewForRow:forComponent:reusingView:)])
//		return nil;
//	return [_pickerDelegate pickerAlert:self viewForRow:row forComponent:component reusingView:view];
//}

//- (CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component
//{
//	if (![_delegate respondsToSelector:@selector(pickerAlert:rowHeightForComponent:)])
//		return nil;
//	return [_delegate pickerAlert:self rowHeightForComponent:component];
//}
//
//- (CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component
//{
//	if (![_delegate respondsToSelector:@selector(pickerAlert:widthForComponent:)])
//		return nil;
//	return [_delegate pickerAlert:self widthForComponent:component];
//}

#pragma mark -  UIAlertViewDelegate

//- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	if ([_delegate respondsToSelector:@selector(pickerAlert:clickedButtonAtIndex:)])
//		[_delegate pickerAlert:self clickedButtonAtIndex:buttonIndex];
//}

//- (void)willPresentAlertView:(UIAlertView*)alertView {
//	if (!_presented)
////		[self layout];
//	_presented = YES;
//	if ([_delegate respondsToSelector:@selector(willPresentPickerAlert:)])
//		[_delegate willPresentPickerAlert:self];
//}

//- (void)didPresentAlertView:(UIAlertView *)alertView {
//	if ([_delegate respondsToSelector:@selector(didPresentPickerAlert:)])
//		[_delegate didPresentPickerAlert:self];
//}

//- (void)alertViewCancel:(UIAlertView*)alertView {
//	if ([_delegate respondsToSelector:@selector(pickerAlertCancel:)])
//		[_delegate pickerAlertCancel:self];
//}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if ([_pickerDelegate respondsToSelector:@selector(pickerAlert:willDismissWithButtonIndex:)])
		[_pickerDelegate pickerAlert:self willDismissWithButtonIndex:buttonIndex];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	_presented = NO;
	if ([_pickerDelegate respondsToSelector:@selector(pickerAlert:didDismissWithButtonIndex:)])
		[_pickerDelegate pickerAlert:self didDismissWithButtonIndex:buttonIndex];
}

@end

//- pickerAlert:clickedButtonAtIndex:
//
//- willPresentPickerAlert:
//- didPresentPickerAlert:
//
//- pickerAlert:willDismissWithButtonIndex:
//- pickerAlert:didDismissWithButtonIndex:
//
//- pickerAlertCancel:
//
//- pickerAlertShouldEnableFirstOtherButton:
//
//- pickerAlert:didSelectRow:inComponent:
//
//- pickerAlert:titleForRow:forComponent:
//- pickerAlert:attributedTitleForRow:forComponent:
//- pickerAlert:viewForRow:forComponent:reusingView:
//
//- pickerAlert:rowHeightForComponent:
//- pickerAlert:widthForComponent:
