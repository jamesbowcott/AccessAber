#import "OSMNode.h"
#import "OSMWay.h"
#import "Application.h"

@implementation OSMNode

+ (CLLocationDistance)distanceBetweenNodes:(NSArray*)nodes {
    CLLocationDistance distance = 0;
    CLLocation *prevLocation = nil;
    
    for (OSMNode* node in nodes) {
        CLLocation *nodeLocation = node.location;
        if (prevLocation) {
            distance += [nodeLocation distanceFromLocation:prevLocation];
        }
        prevLocation = nodeLocation;
    }
    
    return distance;
}

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super initWithId:osmid tags:tags])) {
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"OSMNode %@: %f %f", self.osmid, self.coordinate.latitude, self.coordinate.longitude];
}

- (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
}

- (NSMutableArray *)ways {
    if (!_ways) {
        _ways = [[NSMutableArray alloc] init];
    }
    return _ways;
}



- (NSSet*)adjacentHighwayWays {
    NSMutableSet* adjacentHighwayWays = [[NSMutableSet alloc] initWithCapacity:self.ways.count];
    
    for (OSMWay* way in self.ways) {
        if (way.isNavigable)
            [adjacentHighwayWays addObject:way];
    }
    
    return adjacentHighwayWays;
}

- (NSSet *)adjacentHighwayNodes {
    NSMutableSet *adjacentNodes = [[NSMutableSet alloc] initWithCapacity:self.ways.count];
    
    for (OSMWay* way in self.adjacentHighwayWays) {
        NSUInteger selfIndex = [way.nodes indexOfObject:self];
        if (selfIndex != NSNotFound) {
            // Preceding node
            if (selfIndex > 0)
                [adjacentNodes addObject:[way.nodes objectAtIndex:selfIndex-1]];
            // Proceeding node
            if (selfIndex < way.nodes.count-1)
                [adjacentNodes addObject:[way.nodes objectAtIndex:selfIndex+1]];
        }
    }
    
    return [NSSet setWithSet:adjacentNodes];
}

@end
