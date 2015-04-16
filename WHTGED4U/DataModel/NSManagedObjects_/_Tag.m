// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.m instead.

#import "_Tag.h"

const struct TagAttributes TagAttributes = {
	.sortValue = @"sortValue",
	.tag = @"tag",
};

const struct TagRelationships TagRelationships = {
	.achievements = @"achievements",
};

const struct TagFetchedProperties TagFetchedProperties = {
};

@implementation TagID
@end

@implementation _Tag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (TagID*)objectID {
	return (TagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic sortValue;






@dynamic tag;






@dynamic achievements;

	
- (NSMutableSet*)achievementsSet {
	[self willAccessValueForKey:@"achievements"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"achievements"];
  
	[self didAccessValueForKey:@"achievements"];
	return result;
}
	






@end
