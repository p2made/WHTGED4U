//
//  UITextView+Size.m
//  WHTGED4U
//
//  Created by Pedro fp on 2/07/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "UITextView+Size.h"

@implementation UITextView (Size)

#define kMaxFieldHeight		1000
#define kDefaultMinimumSize	13.0
#define kDefaultMaximumSize	16.0

float fudgeFactor = 16.0;
CGSize tallerSize;
CGSize stringSize;

- (BOOL)setFontSizeToFitMinimumSize:(float)minimumFontSize maximumSize:(float)maximumFontSize
{
	float fontSize = maximumFontSize;
	[self updateWithFontSize:fontSize];
	
	do {
		if (fontSize <= minimumFontSize) // won't fit - EVER!
			return NO;
		fontSize -= 1.0;
		[self updateWithFontSize:fontSize];
	} while (stringSize.height >= [self frame].size.height);
	
	return YES;
}

- (BOOL)setFontSizeToFit
{
	return [self setFontSizeToFitMinimumSize:kDefaultMinimumSize maximumSize:kDefaultMaximumSize];
}

- (void)updateWithFontSize:(float)fontSize
{
	[self setFont:[[self font] fontWithSize:fontSize]];
	tallerSize = CGSizeMake([self frame].size.width - fudgeFactor, kMaxFieldHeight);
	stringSize = [[self text] sizeWithFont:[self font] constrainedToSize:tallerSize lineBreakMode:NSLineBreakByWordWrapping];
}

@end
