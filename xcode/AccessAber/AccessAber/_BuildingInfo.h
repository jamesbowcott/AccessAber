// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct BuildingInfoRelationships {
	__unsafe_unretained NSString *building;
} BuildingInfoRelationships;

@class Building;

@interface BuildingInfoID : InfoID {}
@end

@interface _BuildingInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BuildingInfoID* objectID;

@property (nonatomic, strong) Building *building;

//- (BOOL)validateBuilding:(id*)value_ error:(NSError**)error_;

@end

@interface _BuildingInfo (CoreDataGeneratedPrimitiveAccessors)

- (Building*)primitiveBuilding;
- (void)setPrimitiveBuilding:(Building*)value;

@end
