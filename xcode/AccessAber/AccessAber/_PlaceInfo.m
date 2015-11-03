// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceInfo.m instead.

#import "_PlaceInfo.h"

const struct PlaceInfoRelationships PlaceInfoRelationships = {
	.place = @"place",
};

@implementation PlaceInfoID
@end

@implementation _PlaceInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PlaceInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PlaceInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PlaceInfo" inManagedObjectContext:moc_];
}

- (PlaceInfoID*)objectID {
	return (PlaceInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic place;

@end

