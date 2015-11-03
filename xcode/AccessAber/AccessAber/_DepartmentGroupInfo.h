// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentGroupInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct DepartmentGroupInfoRelationships {
	__unsafe_unretained NSString *departmentGroup;
} DepartmentGroupInfoRelationships;

@class DepartmentGroup;

@interface DepartmentGroupInfoID : InfoID {}
@end

@interface _DepartmentGroupInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DepartmentGroupInfoID* objectID;

@property (nonatomic, strong) DepartmentGroup *departmentGroup;

//- (BOOL)validateDepartmentGroup:(id*)value_ error:(NSError**)error_;

@end

@interface _DepartmentGroupInfo (CoreDataGeneratedPrimitiveAccessors)

- (DepartmentGroup*)primitiveDepartmentGroup;
- (void)setPrimitiveDepartmentGroup:(DepartmentGroup*)value;

@end
