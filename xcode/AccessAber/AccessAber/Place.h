#import "_Place.h"
#import <CoreLocation/CoreLocation.h>

@interface Place : _Place {}
// Custom logic goes here.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@end
