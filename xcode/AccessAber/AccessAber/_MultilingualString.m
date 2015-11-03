// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MultilingualString.m instead.

#import "_MultilingualString.h"

const struct MultilingualStringAttributes MultilingualStringAttributes = {
	.base = @"base",
	.cy = @"cy",
	.en = @"en",
};

@implementation MultilingualStringID
@end

@implementation _MultilingualString

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MultilingualString" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MultilingualString";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MultilingualString" inManagedObjectContext:moc_];
}

- (MultilingualStringID*)objectID {
	return (MultilingualStringID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic base;

@dynamic cy;

@dynamic en;

@end

