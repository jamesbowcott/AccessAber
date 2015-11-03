// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingGroup.h instead.

@import CoreData;
#import "Static.h"

extern const struct BuildingGroupRelationships {
	__unsafe_unretained NSString *buildings;
	__unsafe_unretained NSString *info;
} BuildingGroupRelationships;

@class Building;
@class BuildingGroupInfo;

@interface BuildingGroupID : StaticID {}
@end

@interface _BuildingGroup : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BuildingGroupID* objectID;

@property (nonatomic, strong) NSOrderedSet *buildings;

- (NSMutableOrderedSet*)buildingsSet;

@property (nonatomic, strong) BuildingGroupInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@end

@interface _BuildingGroup (BuildingsCoreDataGeneratedAccessors)
- (void)addBuildings:(NSOrderedSet*)value_;
- (void)removeBuildings:(NSOrderedSet*)value_;
- (void)addBuildingsObject:(Building*)value_;
- (void)removeBuildingsObject:(Building*)value_;

- (void)insertObject:(Building*)value inBuildingsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBuildingsAtIndex:(NSUInteger)idx;
- (void)insertBuildings:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBuildingsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBuildingsAtIndex:(NSUInteger)idx withObject:(Building*)value;
- (void)replaceBuildingsAtIndexes:(NSIndexSet *)indexes withBuildings:(NSArray *)values;

@end

@interface _BuildingGroup (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableOrderedSet*)primitiveBuildings;
- (void)setPrimitiveBuildings:(NSMutableOrderedSet*)value;

- (BuildingGroupInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(BuildingGroupInfo*)value;

@end
