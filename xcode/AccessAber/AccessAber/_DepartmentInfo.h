// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DepartmentInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct DepartmentInfoAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *phone;
} DepartmentInfoAttributes;

extern const struct DepartmentInfoRelationships {
	__unsafe_unretained NSString *department;
	__unsafe_unretained NSString *url;
} DepartmentInfoRelationships;

@class Department;
@class MultilingualString;

@interface DepartmentInfoID : InfoID {}
@end

@interface _DepartmentInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DepartmentInfoID* objectID;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* phone;

//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Department *department;

//- (BOOL)validateDepartment:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MultilingualString *url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@end

@interface _DepartmentInfo (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;

- (Department*)primitiveDepartment;
- (void)setPrimitiveDepartment:(Department*)value;

- (MultilingualString*)primitiveUrl;
- (void)setPrimitiveUrl:(MultilingualString*)value;

@end
