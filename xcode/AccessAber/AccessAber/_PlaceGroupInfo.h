// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceGroupInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct PlaceGroupInfoRelationships {
	__unsafe_unretained NSString *placeGroup;
} PlaceGroupInfoRelationships;

@class PlaceGroup;

@interface PlaceGroupInfoID : InfoID {}
@end

@interface _PlaceGroupInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlaceGroupInfoID* objectID;

@property (nonatomic, strong) PlaceGroup *placeGroup;

//- (BOOL)validatePlaceGroup:(id*)value_ error:(NSError**)error_;

@end

@interface _PlaceGroupInfo (CoreDataGeneratedPrimitiveAccessors)

- (PlaceGroup*)primitivePlaceGroup;
- (void)setPrimitivePlaceGroup:(PlaceGroup*)value;

@end
