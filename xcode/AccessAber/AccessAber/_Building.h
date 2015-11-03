// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Building.h instead.

@import CoreData;
#import "Static.h"

extern const struct BuildingAttributes {
	__unsafe_unretained NSString *osmWay;
} BuildingAttributes;

extern const struct BuildingRelationships {
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *info;
	__unsafe_unretained NSString *places;
} BuildingRelationships;

@class BuildingGroup;
@class BuildingInfo;
@class Place;

@interface BuildingID : StaticID {}
@end

@interface _Building : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BuildingID* objectID;

@property (nonatomic, strong) NSNumber* osmWay;

@property (atomic) int32_t osmWayValue;
- (int32_t)osmWayValue;
- (void)setOsmWayValue:(int32_t)value_;

//- (BOOL)validateOsmWay:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) BuildingGroup *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) BuildingInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *places;

- (NSMutableSet*)placesSet;

@end

@interface _Building (PlacesCoreDataGeneratedAccessors)
- (void)addPlaces:(NSSet*)value_;
- (void)removePlaces:(NSSet*)value_;
- (void)addPlacesObject:(Place*)value_;
- (void)removePlacesObject:(Place*)value_;

@end

@interface _Building (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveOsmWay;
- (void)setPrimitiveOsmWay:(NSNumber*)value;

- (int32_t)primitiveOsmWayValue;
- (void)setPrimitiveOsmWayValue:(int32_t)value_;

- (BuildingGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(BuildingGroup*)value;

- (BuildingInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(BuildingInfo*)value;

- (NSMutableSet*)primitivePlaces;
- (void)setPrimitivePlaces:(NSMutableSet*)value;

@end
