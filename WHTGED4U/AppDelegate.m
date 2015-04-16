//
//  P2AppDelegate.m
//  WHTGED4U
//
//  Created by Pedro fp on 28/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "AppDelegate.h"
#import "P2AchievementsDataset.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	[MagicalRecord setupCoreDataStackWithStoreNamed:@"WHTGED4U.sqlite"];
	[NSManagedObjectContext defaultContext];
	[P2AchievementsDataset shared];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	[MagicalRecord cleanUp];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[MagicalRecord cleanUp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[MagicalRecord cleanUp];
}

@end
