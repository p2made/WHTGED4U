//
//  P2DataModel.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "Achievement.h"
#import "Tag.h"

@interface P2DataModel : NSObject

+ (NSArray*)sortedArrayWithSet:(NSSet*)set key:(NSString*)key ascending:(BOOL)ascending;

@end
