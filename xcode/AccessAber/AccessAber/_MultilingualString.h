// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MultilingualString.h instead.

@import CoreData;

extern const struct MultilingualStringAttributes {
	__unsafe_unretained NSString *base;
	__unsafe_unretained NSString *cy;
	__unsafe_unretained NSString *en;
} MultilingualStringAttributes;

@interface MultilingualStringID : NSManagedObjectID {}
@end

@interface _MultilingualString : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MultilingualStringID* objectID;

@property (nonatomic, strong) NSString* base;

//- (BOOL)validateBase:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* cy;

//- (BOOL)validateCy:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* en;

//- (BOOL)validateEn:(id*)value_ error:(NSError**)error_;

@end

@interface _MultilingualString (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBase;
- (void)setPrimitiveBase:(NSString*)value;

- (NSString*)primitiveCy;
- (void)setPrimitiveCy:(NSString*)value;

- (NSString*)primitiveEn;
- (void)setPrimitiveEn:(NSString*)value;

@end
