// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Department.m instead.

#import "_Department.h"

const struct DepartmentRelationships DepartmentRelationships = {
	.group = @"group",
	.info = @"info",
	.places = @"places",
};

@implementation DepartmentID
@end

@implementation _Department

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Department";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Department" inManagedObjectContext:moc_];
}

- (DepartmentID*)objectID {
	return (DepartmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic group;

@dynamic info;

@dynamic places;

- (NSMutableOrderedSet*)placesSet {
	[self willAccessValueForKey:@"places"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"places"];

	[self didAccessValueForKey:@"places"];
	return result;
}

@end

@implementation _Department (PlacesCoreDataGeneratedAccessors)
- (void)addPlaces:(NSOrderedSet*)value_ {
	[self.placesSet unionOrderedSet:value_];
}
- (void)removePlaces:(NSOrderedSet*)value_ {
	[self.placesSet minusOrderedSet:value_];
}
- (void)addPlacesObject:(Place*)value_ {
	[self.placesSet addObject:value_];
}
- (void)removePlacesObject:(Place*)value_ {
	[self.placesSet removeObject:value_];
}
- (void)insertObject:(Place*)value inPlacesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"places"];
}
- (void)removeObjectFromPlacesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"places"];
}
- (void)insertPlaces:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"places"];
}
- (void)removePlacesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"places"];
}
- (void)replaceObjectInPlacesAtIndex:(NSUInteger)idx withObject:(Place*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"places"];
}
- (void)replacePlacesAtIndexes:(NSIndexSet *)indexes withPlaces:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"places"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self places]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"places"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"places"];
}
@end

