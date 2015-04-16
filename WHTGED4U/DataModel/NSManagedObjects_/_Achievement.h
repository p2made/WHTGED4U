// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Achievement.h instead.

#import <CoreData/CoreData.h>


extern const struct AchievementAttributes {
	__unsafe_unretained NSString *benefit;
	__unsafe_unretained NSString *like;
	__unsafe_unretained NSString *reference;
	__unsafe_unretained NSString *tweet;
	__unsafe_unretained NSString *url;
	__unsafe_unretained NSString *what;
} AchievementAttributes;

extern const struct AchievementRelationships {
	__unsafe_unretained NSString *tags;
} AchievementRelationships;

extern const struct AchievementFetchedProperties {
} AchievementFetchedProperties;

@class Tag;








@interface AchievementID : NSManagedObjectID {}
@end

@interface _Achievement : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AchievementID*)objectID;





@property (nonatomic, strong) NSString* benefit;



//- (BOOL)validateBenefit:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* like;



@property BOOL likeValue;
- (BOOL)likeValue;
- (void)setLikeValue:(BOOL)value_;

//- (BOOL)validateLike:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* reference;



//- (BOOL)validateReference:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tweet;



//- (BOOL)validateTweet:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* what;



//- (BOOL)validateWhat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;





@end

@interface _Achievement (CoreDataGeneratedAccessors)

- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _Achievement (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBenefit;
- (void)setPrimitiveBenefit:(NSString*)value;




- (NSNumber*)primitiveLike;
- (void)setPrimitiveLike:(NSNumber*)value;

- (BOOL)primitiveLikeValue;
- (void)setPrimitiveLikeValue:(BOOL)value_;




- (NSString*)primitiveReference;
- (void)setPrimitiveReference:(NSString*)value;




- (NSString*)primitiveTweet;
- (void)setPrimitiveTweet:(NSString*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




- (NSString*)primitiveWhat;
- (void)setPrimitiveWhat:(NSString*)value;





- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;


@end
