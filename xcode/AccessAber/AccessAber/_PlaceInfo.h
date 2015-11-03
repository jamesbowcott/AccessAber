// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PlaceInfo.h instead.

@import CoreData;
#import "Info.h"

extern const struct PlaceInfoRelationships {
	__unsafe_unretained NSString *place;
} PlaceInfoRelationships;

@class Place;

@interface PlaceInfoID : InfoID {}
@end

@interface _PlaceInfo : Info {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlaceInfoID* objectID;

@property (nonatomic, strong) Place *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;

@end

@interface _PlaceInfo (CoreDataGeneratedPrimitiveAccessors)

- (Place*)primitivePlace;
- (void)setPrimitivePlace:(Place*)value;

@end
