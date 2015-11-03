// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceGroupInfo.m instead.

#import "_PlaceGroupInfo.h"

const struct PlaceGroupInfoRelationships PlaceGroupInfoRelationships = {
	.placeGroup = @"placeGroup",
};

@implementation PlaceGroupInfoID
@end

@implementation _PlaceGroupInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PlaceGroupInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PlaceGroupInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PlaceGroupInfo" inManagedObjectContext:moc_];
}

- (PlaceGroupInfoID*)objectID {
	return (PlaceGroupInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic placeGroup;

@end

