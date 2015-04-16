//
//  P2AchievementsDataset.h
//  WHTGED4U
//
//  Created by Pedro fp on 4/07/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Achievement;

@interface P2AchievementsDataset : NSObject

typedef enum {
	P2FilterUnchanged = -1,
	P2Unfiltered,
	P2FilteredByLike,
	P2FilteredByTag
} P2FilterState;

+ (id)shared;

@property (readonly, nonatomic) P2FilterState filterState;

- (Achievement*)objectAtIndex:(NSUInteger)index;
- (NSUInteger)count;

- (void)fetchDataForFilterState:(P2FilterState)state withTag:(NSString*)tagValue;


@end
