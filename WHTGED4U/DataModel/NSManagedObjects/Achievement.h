//
//  Achievement.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

// NSString		what
// NSString		tweet
// NSString		benefit
// NSString		reference
// NSString		url
// NSSet		tags
// NSNumber		like
// NSNumber		random

#import "P2DataModel.h"
#import "_Achievement.h"

@interface Achievement : _Achievement {}

- (BOOL)hasTags;
- (NSArray*)tagsArray;
- (NSArray*)tagsValues;
- (NSString*)tagsList;
- (UIImage*)likeImageInList:(BOOL)inList;


@end
