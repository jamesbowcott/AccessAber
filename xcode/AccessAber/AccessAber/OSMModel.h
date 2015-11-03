#import "OSMElement.h"
#import "OSMNode.h"
#import "OSMWay.h"
#import "OSMRelation.h"
#import "OSMBuilding.h"

@interface OSMModel : NSObject

@property (nonatomic, readonly) NSDictionary *nodes;
@property (nonatomic, readonly) NSDictionary *ways;
@property (nonatomic, readonly) NSDictionary *relations;

@property (nonatomic, readonly) NSOrderedSet *orderedWays;
@property (nonatomic, readonly) NSSet *highways;
@property (nonatomic, readonly) NSSet *buildings;



//@property (nonatomic, readonly) NSMutableOrderedSet *orderedWayKeys;

- (OSMElement*)elementWithId:(OSMIdentifier*)osmid;

- (void)addNode:(OSMNode*)node;
- (void)addWay:(OSMWay*)way;
- (void)addRelation:(OSMRelation*)relation;

@end