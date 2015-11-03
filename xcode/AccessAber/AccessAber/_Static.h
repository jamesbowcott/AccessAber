// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Static.h instead.

@import CoreData;

extern const struct StaticAttributes {
	__unsafe_unretained NSString *key;
} StaticAttributes;

@interface StaticID : NSManagedObjectID {}
@end

@interface _Static : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) StaticID* objectID;

@property (nonatomic, strong) NSString* key;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;

@end

@interface _Static (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveKey;
- (void)setPrimitiveKey:(NSString*)value;

@end
