// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BuildingGroupInfo.m instead.

#import "_BuildingGroupInfo.h"

const struct BuildingGroupInfoRelationships BuildingGroupInfoRelationships = {
	.buildingGroup = @"buildingGroup",
};

@implementation BuildingGroupInfoID
@end

@implementation _BuildingGroupInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BuildingGroupInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BuildingGroupInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BuildingGroupInfo" inManagedObjectContext:moc_];
}

- (BuildingGroupInfoID*)objectID {
	return (BuildingGroupInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic buildingGroup;

@end

