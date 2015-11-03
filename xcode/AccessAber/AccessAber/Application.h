#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "OSMModel.h"
#import "MapController.h"

NS_ENUM(NSUInteger, AccessibilityLevel) {
    AccessibilityLevelSteps, AccessibilityLevelNoSteps
};

@interface Application : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *staticManagedObjectContext;
@property (nonatomic) OSMModel *osm;
@property (nonatomic) MapController *mapController;
@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic) NSUInteger accessibilityLevel;

+ (instancetype)sharedApplication;
- (BOOL)requestLocationServices;
@end
