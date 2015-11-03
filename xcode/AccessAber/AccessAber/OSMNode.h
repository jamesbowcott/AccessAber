#import "OSMElement.h"
#import <CoreLocation/CoreLocation.h>

@interface OSMNode : OSMElement

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CLLocation *location;

@property (nonatomic) NSMutableArray* ways;
@property (nonatomic, readonly) NSSet* adjacentHighwayWays;
@property (nonatomic, readonly) NSSet* adjacentHighwayNodes;

+ (CLLocationDistance)distanceBetweenNodes:(NSArray*)nodes;
- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags coordinate:(CLLocationCoordinate2D)coordinate;

@end
