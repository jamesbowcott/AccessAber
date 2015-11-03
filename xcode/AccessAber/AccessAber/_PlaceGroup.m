// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceGroup.m instead.

#import "_PlaceGroup.h"

const struct PlaceGroupRelationships PlaceGroupRelationships = {
	.info = @"info",
	.places = @"places",
};

@implementation PlaceGroupID
@end

@implementation _PlaceGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PlaceGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PlaceGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PlaceGroup" inManagedObjectContext:moc_];
}

- (PlaceGroupID*)objectID {
	return (PlaceGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic info;

@dynamic places;

- (NSMutableSet*)placesSet {
	[self willAccessValueForKey:@"places"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"places"];

	[self didAccessValueForKey:@"places"];
	return result;
}

@end

