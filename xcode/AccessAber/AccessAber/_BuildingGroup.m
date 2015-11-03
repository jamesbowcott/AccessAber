// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingGroup.m instead.

#import "_BuildingGroup.h"

const struct BuildingGroupRelationships BuildingGroupRelationships = {
	.buildings = @"buildings",
	.info = @"info",
};

@implementation BuildingGroupID
@end

@implementation _BuildingGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BuildingGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BuildingGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BuildingGroup" inManagedObjectContext:moc_];
}

- (BuildingGroupID*)objectID {
	return (BuildingGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic buildings;

- (NSMutableOrderedSet*)buildingsSet {
	[self willAccessValueForKey:@"buildings"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"buildings"];

	[self didAccessValueForKey:@"buildings"];
	return result;
}

@dynamic info;

@end

@implementation _BuildingGroup (BuildingsCoreDataGeneratedAccessors)
- (void)addBuildings:(NSOrderedSet*)value_ {
	[self.buildingsSet unionOrderedSet:value_];
}
- (void)removeBuildings:(NSOrderedSet*)value_ {
	[self.buildingsSet minusOrderedSet:value_];
}
- (void)addBuildingsObject:(Building*)value_ {
	[self.buildingsSet addObject:value_];
}
- (void)removeBuildingsObject:(Building*)value_ {
	[self.buildingsSet removeObject:value_];
}
- (void)insertObject:(Building*)value inBuildingsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"buildings"];
}
- (void)removeObjectFromBuildingsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"buildings"];
}
- (void)insertBuildings:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"buildings"];
}
- (void)removeBuildingsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"buildings"];
}
- (void)replaceObjectInBuildingsAtIndex:(NSUInteger)idx withObject:(Building*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"buildings"];
}
- (void)replaceBuildingsAtIndexes:(NSIndexSet *)indexes withBuildings:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"buildings"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self buildings]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"buildings"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"buildings"];
}
@end

