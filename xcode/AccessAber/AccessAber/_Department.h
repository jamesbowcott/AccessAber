// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Department.h instead.

@import CoreData;
#import "Static.h"

extern const struct DepartmentRelationships {
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *info;
	__unsafe_unretained NSString *places;
} DepartmentRelationships;

@class DepartmentGroup;
@class DepartmentInfo;
@class Place;

@interface DepartmentID : StaticID {}
@end

@interface _Department : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DepartmentID* objectID;

@property (nonatomic, strong) DepartmentGroup *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) DepartmentInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *places;

- (NSMutableOrderedSet*)placesSet;

@end

@interface _Department (PlacesCoreDataGeneratedAccessors)
- (void)addPlaces:(NSOrderedSet*)value_;
- (void)removePlaces:(NSOrderedSet*)value_;
- (void)addPlacesObject:(Place*)value_;
- (void)removePlacesObject:(Place*)value_;

- (void)insertObject:(Place*)value inPlacesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlacesAtIndex:(NSUInteger)idx;
- (void)insertPlaces:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlacesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlacesAtIndex:(NSUInteger)idx withObject:(Place*)value;
- (void)replacePlacesAtIndexes:(NSIndexSet *)indexes withPlaces:(NSArray *)values;

@end

@interface _Department (CoreDataGeneratedPrimitiveAccessors)

- (DepartmentGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(DepartmentGroup*)value;

- (DepartmentInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(DepartmentInfo*)value;

- (NSMutableOrderedSet*)primitivePlaces;
- (void)setPrimitivePlaces:(NSMutableOrderedSet*)value;

@end
