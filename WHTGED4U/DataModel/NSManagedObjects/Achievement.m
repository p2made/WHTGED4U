//
//  Achievement.m
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "Achievement.h"
#import "Tag.h"

@interface Achievement ()

@end

// NSString		what
// NSString		tweet
// NSString		benefit
// NSString		reference
// NSString		url
// NSSet		tags
// NSNumber		like
// NSNumber		random

@implementation Achievement

- (BOOL)hasTags
{
	if (![self tags] || 0 == [[self tags] count])
		return NO;
	return YES;
}

- (NSArray*)tagsArray
{
	if (![self tags] || [[self tags] count] == 0)
		return nil;
	return [P2DataModel sortedArrayWithSet:[self tags] key:kA_sortValue ascending:YES];
}

- (NSArray*)tagsValues
{
	NSArray* sortedTags = [self tagsArray];
	if (!sortedTags)
		return nil;
	NSMutableArray* tempTags = [NSMutableArray arrayWithCapacity:[sortedTags count]];
	for (Tag* item in sortedTags) {
		if (!item) break;
		[tempTags addObject:[item tag]];
	}
	if (0 == [tempTags count])
		return nil;
	return [NSArray arrayWithArray:tempTags];
}

- (NSString*)tagsList
{
	if (![self tagsValues])
		return nil;
	return [[self tagsValues] componentsJoinedByString:@", "];
}

- (UIImage*)likeImageInList:(BOOL)inList
{
	if (inList)
		return [UIImage imageNamed:([self likeValue] ? kListIconThumbUpBlue : kListIconBulletGrey)];
	else
		return [UIImage imageNamed:([self likeValue] ? kThumbUpBlue : kThumbUpGrey)];
}

@end
