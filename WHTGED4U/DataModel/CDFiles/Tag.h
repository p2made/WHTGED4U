//
//  Tag.h
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Achievement;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) Achievement *achievements;

@end
