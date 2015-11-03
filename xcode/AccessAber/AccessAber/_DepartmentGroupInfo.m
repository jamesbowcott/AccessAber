// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentGroupInfo.m instead.

#import "_DepartmentGroupInfo.h"

const struct DepartmentGroupInfoRelationships DepartmentGroupInfoRelationships = {
	.departmentGroup = @"departmentGroup",
};

@implementation DepartmentGroupInfoID
@end

@implementation _DepartmentGroupInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DepartmentGroupInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DepartmentGroupInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DepartmentGroupInfo" inManagedObjectContext:moc_];
}

- (DepartmentGroupInfoID*)objectID {
	return (DepartmentGroupInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic departmentGroup;

@end

