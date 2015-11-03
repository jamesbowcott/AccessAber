

#import "OSMWay.h"
#import "MapWayStyle.h"
#import "Application.h"

@implementation OSMWay

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags nodes:(NSArray *)nodes {
    if ((self = [super initWithId:osmid tags:tags])) {
        self.nodes = nodes;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"OSMWay %@", self.osmid];
}

- (void)setNodes:(NSArray *)nodes {
    _nodes = nodes;
    for (OSMNode* node in nodes) {
        [node.ways addObject:self];
    }
}

# pragma mark - Properties

- (bool)isClosed {
    return [self.nodes firstObject] == [self.nodes lastObject];
}

- (bool)isIndoor {
    return (self.tags[@"indoor"]);
}

- (bool)isBuilding {
    return (self.tags[@"building"]);
}

- (NSInteger)zIndex {
    __block NSInteger z = 0;
    
    z = [MapWayStyle zIndexForWay:self];
    
    if (self.tags[@"layer"]) {
        z += [self.tags[@"layer"] integerValue] * 100;
    }
    
    return z;
}

# pragma mark Highway properties

- (bool)isHighway {
    return self.tags[@"highway"] != nil;
}

- (bool)isSteps {
    return [self.tags[@"highway"] isEqualToString:@"steps"];
}

- (CLLocationDistance)distance {
    return [OSMNode distanceBetweenNodes:self.nodes];
}

- (bool) isNavigable {
    if (self.isHighway) {
        if ([Application sharedApplication].accessibilityLevel < 1 || !self.isSteps) {
            return YES;
        }
    }
    return NO;
}

@end
