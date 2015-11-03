// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceGroup.h instead.

@import CoreData;
#import "Static.h"

extern const struct PlaceGroupRelationships {
	__unsafe_unretained NSString *info;
	__unsafe_unretained NSString *places;
} PlaceGroupRelationships;

@class PlaceGroupInfo;
@class Place;

@interface PlaceGroupID : StaticID {}
@end

@interface _PlaceGroup : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlaceGroupID* objectID;

@property (nonatomic, strong) PlaceGroupInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *places;

- (NSMutableSet*)placesSet;

@end

@interface _PlaceGroup (PlacesCoreDataGeneratedAccessors)
- (void)addPlaces:(NSSet*)value_;
- (void)removePlaces:(NSSet*)value_;
- (void)addPlacesObject:(Place*)value_;
- (void)removePlacesObject:(Place*)value_;

@end

@interface _PlaceGroup (CoreDataGeneratedPrimitiveAccessors)

- (PlaceGroupInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(PlaceGroupInfo*)value;

- (NSMutableSet*)primitivePlaces;
- (void)setPrimitivePlaces:(NSMutableSet*)value;

@end
