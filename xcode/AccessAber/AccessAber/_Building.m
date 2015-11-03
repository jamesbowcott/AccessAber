// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Building.m instead.

#import "_Building.h"

const struct BuildingAttributes BuildingAttributes = {
	.osmWay = @"osmWay",
};

const struct BuildingRelationships BuildingRelationships = {
	.group = @"group",
	.info = @"info",
	.places = @"places",
};

@implementation BuildingID
@end

@implementation _Building

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Building";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Building" inManagedObjectContext:moc_];
}

- (BuildingID*)objectID {
	return (BuildingID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"osmWayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"osmWay"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic osmWay;

- (int32_t)osmWayValue {
	NSNumber *result = [self osmWay];
	return [result intValue];
}

- (void)setOsmWayValue:(int32_t)value_ {
	[self setOsmWay:@(value_)];
}

- (int32_t)primitiveOsmWayValue {
	NSNumber *result = [self primitiveOsmWay];
	return [result intValue];
}

- (void)setPrimitiveOsmWayValue:(int32_t)value_ {
	[self setPrimitiveOsmWay:@(value_)];
}

@dynamic group;

@dynamic info;

@dynamic places;

- (NSMutableSet*)placesSet {
	[self willAccessValueForKey:@"places"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"places"];

	[self didAccessValueForKey:@"places"];
	return result;
}

@end

