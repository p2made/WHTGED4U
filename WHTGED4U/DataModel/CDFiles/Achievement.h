//
//  Achievement.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2DataModel.h"

@class Tag;

@interface Achievement : NSManagedObject

@property (nonatomic, retain) NSString * what;
@property (nonatomic, retain) NSString * tweet;
@property (nonatomic, retain) NSString * benefit;
@property (nonatomic, retain) NSString * reference;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Tag *tags;

@end
