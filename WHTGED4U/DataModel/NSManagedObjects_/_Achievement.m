// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Achievement.m instead.

#import "_Achievement.h"

const struct AchievementAttributes AchievementAttributes = {
	.benefit = @"benefit",
	.like = @"like",
	.reference = @"reference",
	.tweet = @"tweet",
	.url = @"url",
	.what = @"what",
};

const struct AchievementRelationships AchievementRelationships = {
	.tags = @"tags",
};

const struct AchievementFetchedProperties AchievementFetchedProperties = {
};

@implementation AchievementID
@end

@implementation _Achievement

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Achievement" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Achievement";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Achievement" inManagedObjectContext:moc_];
}

- (AchievementID*)objectID {
	return (AchievementID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"likeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"like"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic benefit;






@dynamic like;



- (BOOL)likeValue {
	NSNumber *result = [self like];
	return [result boolValue];
}

- (void)setLikeValue:(BOOL)value_ {
	[self setLike:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveLikeValue {
	NSNumber *result = [self primitiveLike];
	return [result boolValue];
}

- (void)setPrimitiveLikeValue:(BOOL)value_ {
	[self setPrimitiveLike:[NSNumber numberWithBool:value_]];
}





@dynamic reference;






@dynamic tweet;






@dynamic url;






@dynamic what;






@dynamic tags;

	
- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];
  
	[self didAccessValueForKey:@"tags"];
	return result;
}
	






@end
