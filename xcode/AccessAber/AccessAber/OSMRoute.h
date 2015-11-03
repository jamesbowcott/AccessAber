#import "OSMModel.h"

@interface OSMRoute : OSMWay

- (instancetype)initWithNodes:(NSArray*)nodes;

+ (instancetype)shortestRouteInModel:(OSMModel*)model fromNode:(OSMNode *)startNode toNode:(OSMNode *)endNode;

@end
