// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentInfo.m instead.

#import "_DepartmentInfo.h"

const struct DepartmentInfoAttributes DepartmentInfoAttributes = {
	.email = @"email",
	.phone = @"phone",
};

const struct DepartmentInfoRelationships DepartmentInfoRelationships = {
	.department = @"department",
	.url = @"url",
};

@implementation DepartmentInfoID
@end

@implementation _DepartmentInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DepartmentInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DepartmentInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DepartmentInfo" inManagedObjectContext:moc_];
}

- (DepartmentInfoID*)objectID {
	return (DepartmentInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic email;

@dynamic phone;

@dynamic department;

@dynamic url;

@end

