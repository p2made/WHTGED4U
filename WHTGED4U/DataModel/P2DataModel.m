//
//  P2DataModel.m
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2DataModel.h"

@implementation P2DataModel

+ (NSArray*)sortedArrayWithSet:(NSSet*)set key:(NSString*)key ascending:(BOOL)ascending
{
	NSMutableArray *temp = [NSMutableArray arrayWithArray:[set allObjects]];
	NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	[temp sortUsingDescriptors:@[descriptor]];
	return [NSArray arrayWithArray:temp];
}


@end
