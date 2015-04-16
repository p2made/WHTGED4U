// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.h instead.

#import <CoreData/CoreData.h>


extern const struct TagAttributes {
	__unsafe_unretained NSString *sortValue;
	__unsafe_unretained NSString *tag;
} TagAttributes;

extern const struct TagRelationships {
	__unsafe_unretained NSString *achievements;
} TagRelationships;

extern const struct TagFetchedProperties {
} TagFetchedProperties;

@class Achievement;




@interface TagID : NSManagedObjectID {}
@end

@interface _Tag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TagID*)objectID;





@property (nonatomic, strong) NSString* sortValue;



//- (BOOL)validateSortValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tag;



//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *achievements;

- (NSMutableSet*)achievementsSet;





@end

@interface _Tag (CoreDataGeneratedAccessors)

- (void)addAchievements:(NSSet*)value_;
- (void)removeAchievements:(NSSet*)value_;
- (void)addAchievementsObject:(Achievement*)value_;
- (void)removeAchievementsObject:(Achievement*)value_;

@end

@interface _Tag (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveSortValue;
- (void)setPrimitiveSortValue:(NSString*)value;




- (NSString*)primitiveTag;
- (void)setPrimitiveTag:(NSString*)value;





- (NSMutableSet*)primitiveAchievements;
- (void)setPrimitiveAchievements:(NSMutableSet*)value;


@end
