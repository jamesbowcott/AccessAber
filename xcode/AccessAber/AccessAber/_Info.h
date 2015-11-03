// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Info.h instead.

@import CoreData;

extern const struct InfoRelationships {
	__unsafe_unretained NSString *name;
} InfoRelationships;

@class MultilingualString;

@interface InfoID : NSManagedObjectID {}
@end

@interface _Info : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InfoID* objectID;

@property (nonatomic, strong) MultilingualString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _Info (CoreDataGeneratedPrimitiveAccessors)

- (MultilingualString*)primitiveName;
- (void)setPrimitiveName:(MultilingualString*)value;

@end
