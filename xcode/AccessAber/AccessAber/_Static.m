// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Static.m instead.

#import "_Static.h"

const struct StaticAttributes StaticAttributes = {
	.key = @"key",
};

@implementation StaticID
@end

@implementation _Static

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Static" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Static";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Static" inManagedObjectContext:moc_];
}

- (StaticID*)objectID {
	return (StaticID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic key;

@end

