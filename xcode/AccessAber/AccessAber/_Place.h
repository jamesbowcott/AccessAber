// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Place.h instead.

@import CoreData;
#import "Static.h"

extern const struct PlaceAttributes {
	__unsafe_unretained NSString *floor;
	__unsafe_unretained NSString *lat;
	__unsafe_unretained NSString *lon;
} PlaceAttributes;

extern const struct PlaceRelationships {
	__unsafe_unretained NSString *building;
	__unsafe_unretained NSString *departments;
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *info;
} PlaceRelationships;

@class Building;
@class Department;
@class PlaceGroup;
@class PlaceInfo;

@interface PlaceID : StaticID {}
@end

@interface _Place : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlaceID* objectID;

@property (nonatomic, strong) NSString* floor;

//- (BOOL)validateFloor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lat;

@property (atomic) double latValue;
- (double)latValue;
- (void)setLatValue:(double)value_;

//- (BOOL)validateLat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* lon;

@property (atomic) double lonValue;
- (double)lonValue;
- (void)setLonValue:(double)value_;

//- (BOOL)validateLon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Building *building;

//- (BOOL)validateBuilding:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *departments;

- (NSMutableSet*)departmentsSet;

@property (nonatomic, strong) PlaceGroup *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) PlaceInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@end

@interface _Place (DepartmentsCoreDataGeneratedAccessors)
- (void)addDepartments:(NSSet*)value_;
- (void)removeDepartments:(NSSet*)value_;
- (void)addDepartmentsObject:(Department*)value_;
- (void)removeDepartmentsObject:(Department*)value_;

@end

@interface _Place (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFloor;
- (void)setPrimitiveFloor:(NSString*)value;

- (NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(NSNumber*)value;

- (double)primitiveLatValue;
- (void)setPrimitiveLatValue:(double)value_;

- (NSNumber*)primitiveLon;
- (void)setPrimitiveLon:(NSNumber*)value;

- (double)primitiveLonValue;
- (void)setPrimitiveLonValue:(double)value_;

- (Building*)primitiveBuilding;
- (void)setPrimitiveBuilding:(Building*)value;

- (NSMutableSet*)primitiveDepartments;
- (void)setPrimitiveDepartments:(NSMutableSet*)value;

- (PlaceGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(PlaceGroup*)value;

- (PlaceInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(PlaceInfo*)value;

@end
