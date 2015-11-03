#import "OSMElement.h"
#import "OSMNode.h"

@interface OSMWay : OSMElement

@property (nonatomic) NSArray *nodes;
@property (nonatomic, readonly) bool isClosed;
@property (nonatomic, readonly) bool isIndoor;
@property (nonatomic, readonly) bool isBuilding;
@property (nonatomic, readonly) NSInteger zIndex;

// Highways only
@property (nonatomic, readonly) bool isHighway;
@property (nonatomic, readonly) bool isSteps;
@property (nonatomic, readonly) CLLocationDistance distance;
@property (nonatomic, readonly) bool isNavigable;

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags nodes:(NSArray*)nodes;

@end
