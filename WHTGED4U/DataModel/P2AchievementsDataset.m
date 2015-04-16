//
//  P2AchievementsDataset.m
//  WHTGED4U
//
//  Created by Pedro fp on 4/07/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2AchievementsDataset.h"
#import "Achievement.h"
#import "Tag.h"

@interface P2AchievementsDataset ()

@property (strong, nonatomic) NSArray* data;
@property (readonly, nonatomic) NSString* filterTag;


@end

@implementation P2AchievementsDataset

static P2AchievementsDataset *sharedDataset = nil;

+ (id)shared
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedDataset = [[self alloc] init];
	});
	return sharedDataset;
}

- (id)init
{
	if (![super init]) return nil;
	[self fetchDataForFilterState:P2Unfiltered withTag:nil];
	return self;
}

- (Achievement*)objectAtIndex:(NSUInteger)index
{
	if (![_data count])
		return nil;
	return [_data objectAtIndex:index];
}

- (NSUInteger)count
{
	return [_data count];
}

- (void)fetchDataForFilterState:(P2FilterState)state withTag:(NSString*)tagValue
{
	if (P2FilterUnchanged == state)
		return;
	
	NSMutableArray* tempArray;
	
	if (state == P2Unfiltered) {
		tempArray = [NSMutableArray arrayWithArray:[Achievement findAll]];
	} else if (state == P2FilteredByLike) {
		tempArray = [NSMutableArray arrayWithArray:[Achievement findByAttribute:kA_like withValue:[NSNumber numberWithBool:YES]]];
	} else if (state == P2FilteredByTag) {
		Tag* filterTag = [Tag findFirstByAttribute:kA_tag withValue:tagValue];
		NSSet* achievements = [filterTag achievements];
		tempArray = [NSMutableArray arrayWithArray:[achievements allObjects]];
	} else {
		return;
	}
	
	NSLog(@"tempArray count: %i", [tempArray count]);
	if (!tempArray || 0 == [tempArray count])
		return;
	
	NSUInteger count = [tempArray count];
	if (count > 1) {
		for (uint i = 0; i < count; ++i)
			[tempArray exchangeObjectAtIndex:i withObjectAtIndex:(arc4random_uniform(count - i) + i)];
	}
	_filterState = state;
	_data = [NSArray arrayWithArray:tempArray];
	NSLog(@"_data count: %i", [_data count]);
}

@end
