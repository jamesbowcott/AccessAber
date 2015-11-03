// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentGroup.h instead.

@import CoreData;
#import "Static.h"

extern const struct DepartmentGroupRelationships {
	__unsafe_unretained NSString *departments;
	__unsafe_unretained NSString *info;
} DepartmentGroupRelationships;

@class Department;
@class DepartmentGroupInfo;

@interface DepartmentGroupID : StaticID {}
@end

@interface _DepartmentGroup : Static {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DepartmentGroupID* objectID;

@property (nonatomic, strong) NSSet *departments;

- (NSMutableSet*)departmentsSet;

@property (nonatomic, strong) DepartmentGroupInfo *info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@end

@interface _DepartmentGroup (DepartmentsCoreDataGeneratedAccessors)
- (void)addDepartments:(NSSet*)value_;
- (void)removeDepartments:(NSSet*)value_;
- (void)addDepartmentsObject:(Department*)value_;
- (void)removeDepartmentsObject:(Department*)value_;

@end

@interface _DepartmentGroup (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableSet*)primitiveDepartments;
- (void)setPrimitiveDepartments:(NSMutableSet*)value;

- (DepartmentGroupInfo*)primitiveInfo;
- (void)setPrimitiveInfo:(DepartmentGroupInfo*)value;

@end
