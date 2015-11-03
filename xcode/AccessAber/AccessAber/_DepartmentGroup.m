// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentGroup.m instead.

#import "_DepartmentGroup.h"

const struct DepartmentGroupRelationships DepartmentGroupRelationships = {
	.departments = @"departments",
	.info = @"info",
};

@implementation DepartmentGroupID
@end

@implementation _DepartmentGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DepartmentGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DepartmentGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DepartmentGroup" inManagedObjectContext:moc_];
}

- (DepartmentGroupID*)objectID {
	return (DepartmentGroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic departments;

- (NSMutableSet*)departmentsSet {
	[self willAccessValueForKey:@"departments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"departments"];

	[self didAccessValueForKey:@"departments"];
	return result;
}

@dynamic info;

@end

