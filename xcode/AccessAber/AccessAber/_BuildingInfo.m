// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingInfo.m instead.

#import "_BuildingInfo.h"

const struct BuildingInfoRelationships BuildingInfoRelationships = {
	.building = @"building",
};

@implementation BuildingInfoID
@end

@implementation _BuildingInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BuildingInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BuildingInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BuildingInfo" inManagedObjectContext:moc_];
}

- (BuildingInfoID*)objectID {
	return (BuildingInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic building;

@end

