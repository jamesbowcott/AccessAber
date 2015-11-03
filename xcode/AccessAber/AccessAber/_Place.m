// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Place.m instead.

#import "_Place.h"

const struct PlaceAttributes PlaceAttributes = {
	.floor = @"floor",
	.lat = @"lat",
	.lon = @"lon",
};

const struct PlaceRelationships PlaceRelationships = {
	.building = @"building",
	.departments = @"departments",
	.group = @"group",
	.info = @"info",
};

@implementation PlaceID
@end

@implementation _Place

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Place";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Place" inManagedObjectContext:moc_];
}

- (PlaceID*)objectID {
	return (PlaceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"latValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lonValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lon"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic floor;

@dynamic lat;

- (double)latValue {
	NSNumber *result = [self lat];
	return [result doubleValue];
}

- (void)setLatValue:(double)value_ {
	[self setLat:@(value_)];
}

- (double)primitiveLatValue {
	NSNumber *result = [self primitiveLat];
	return [result doubleValue];
}

- (void)setPrimitiveLatValue:(double)value_ {
	[self setPrimitiveLat:@(value_)];
}

@dynamic lon;

- (double)lonValue {
	NSNumber *result = [self lon];
	return [result doubleValue];
}

- (void)setLonValue:(double)value_ {
	[self setLon:@(value_)];
}

- (double)primitiveLonValue {
	NSNumber *result = [self primitiveLon];
	return [result doubleValue];
}

- (void)setPrimitiveLonValue:(double)value_ {
	[self setPrimitiveLon:@(value_)];
}

@dynamic building;

@dynamic departments;

- (NSMutableSet*)departmentsSet {
	[self willAccessValueForKey:@"departments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departments"];

	[self didAccessValueForKey:@"departments"];
	return result;
}

@dynamic group;

@dynamic info;

@end

