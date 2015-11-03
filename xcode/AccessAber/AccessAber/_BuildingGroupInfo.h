// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingGroupInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct BuildingGroupInfoRelationships {
	__unsafe_unretained NSString *buildingGroup;
} BuildingGroupInfoRelationships;

@class BuildingGroup;

@interface BuildingGroupInfoID : InfoID {}
@end

@interface _BuildingGroupInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BuildingGroupInfoID* objectID;

@property (nonatomic, strong) BuildingGroup *buildingGroup;

//- (BOOL)validateBuildingGroup:(id*)value_ error:(NSError**)error_;

@end

@interface _BuildingGroupInfo (CoreDataGeneratedPrimitiveAccessors)

- (BuildingGroup*)primitiveBuildingGroup;
- (void)setPrimitiveBuildingGroup:(BuildingGroup*)value;

@end
