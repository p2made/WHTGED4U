//
//  P2DataSynchroniser.m
//  WHTGED4U
//
//  Created by Pedro Plowman on 16/08/13.
//  Copyright (c) 2013 Pedro Plowman. All rights reserved.
//

#import "P2DataSynchroniser.h"
#import "P2DataModel.h"

@interface P2DataSynchroniser ()

@end

@implementation P2DataSynchroniser {
	id<P2DataSynchroniserDelegate> _delegate;
}

BOOL _usingHUD = NO;

- (instancetype)initWithDelegate:(id<P2DataSynchroniserDelegate>)delegate usingHUD:(BOOL)usingHUD
{
	if (![super init])
		return nil;
	_delegate = delegate;
	_usingHUD = usingHUD;
	return self;
}

- (void)synchronise
{
	NSLog(@"synchronising data");
	// API URL...
	// http://whathasthegovernmenteverdoneforus.com/api.json
	
	NSURL *url = [NSURL URLWithString:@"http://whathasthegovernmenteverdoneforus.com/api.json"];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue new] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
		if (error) {
			[self synchronisationFailedWithError:error];
			return;
		}
		
		BOOL success = [self processSynchronisationData:data];
		if (success)
			[self synchronisationCompleted];
		else
			[self synchronisationFailedWithError:nil];
	}];
}

- (BOOL)processSynchronisationData:(NSData*)data
{
	NSLog(@"processing sync data");
	NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
	NSString* updateDate = [dataDictionary objectForKey:kCreated_at];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *lastUpdated = [defaults stringForKey:kLastUpdate];
	if ([lastUpdated compare:updateDate] == NSOrderedAscending) {
		NSLog(@"processing sync data aborted");
		return YES;
	}
	
	NSDictionary* achievements = [dataDictionary objectForKey:kAchievements];
	NSInteger count = [achievements count];
	id __unsafe_unretained objects[count];
	id __unsafe_unretained keys[count];
	[achievements getObjects:objects andKeys:keys];
	for (int i = 0; i < count; i++) {
		NSString* reference = keys[i];
		NSDictionary* data = objects[i];
		[self processAchievementWithReference:reference data:data];
	}
	
	[[NSUserDefaults standardUserDefaults] setValue:updateDate forKey:kLastUpdate];
	NSLog(@"Synchronised!");
	return YES;
}

- (void)processAchievementWithReference:(NSString*)reference data:(NSDictionary*)data
{
	NSLog(@"processing achievement: %@, %@", reference, [data description]);
	
	NSArray* tagsData = [data objectForKey:kA_tags];
	BOOL hasTags = [self achievementHasTags:tagsData];
	
	[MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
		Achievement *achievement = [Achievement findFirstByAttribute:kA_reference withValue:reference inContext:localContext];
		
		if (!achievement)
			achievement = [Achievement createInContext:localContext];
		
		[achievement setReference:reference];
		[achievement setBenefit:[data objectForKey:kA_benefit]];
		[achievement setTweet:[data objectForKey:kA_tweet]];
		[achievement setWhat:[data objectForKey:kA_what]];
		NSString* achievementURL = [data objectForKey:kA_url];
		if ([achievementURL isKindOfClass:[NSString class]])
			[achievement setUrl:achievementURL];
		if (hasTags) {
			NSMutableSet *tempTags = [NSMutableSet setWithCapacity:[tagsData count]];
			for (NSString *item in tagsData) {
				Tag *tag = [Tag findFirstByAttribute:kA_tag withValue:item inContext:localContext];
				if (!tag) continue;
				[tempTags addObject:tag];
			}
			[achievement setTags:[NSSet setWithSet:tempTags]];
		}
	}];
}

- (BOOL)achievementHasTags:(id)tagsData
{
	if (![tagsData isKindOfClass:[NSArray class]]) return NO;
	if (0 == [tagsData count]) return NO;
	
	[MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext* localContext) {
		for (NSString *item in tagsData) {
			Tag *tag = [Tag findFirstByAttribute:kA_tag withValue:item inContext:localContext];
			if (tag) continue;
			
			tag = [Tag createInContext:localContext];
			[tag setTag:item];
			[tag setSortValue:[item lowercaseString]];
		}
	}];
	return YES;
}

- (void)synchronisationFailedWithError:(NSError*)error
{
	if (error)
		NSLog(@"DATA FETCH ERROR: %@", [error localizedDescription]);
	else
		NSLog(@"SYNCHRONISATION FAILED");
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[_delegate synchronisationFailed];
	});
}

- (void)synchronisationCompleted
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[_delegate synchronisationCompleted];
	});
}

@end
