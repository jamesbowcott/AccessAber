// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Info.m instead.

#import "_Info.h"

const struct InfoRelationships InfoRelationships = {
	.name = @"name",
};

@implementation InfoID
@end

@implementation _Info

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Info" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Info";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Info" inManagedObjectContext:moc_];
}

- (InfoID*)objectID {
	return (InfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@end

