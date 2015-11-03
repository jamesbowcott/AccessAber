
#import "OSMModel.h"
#import "Application.h"

@implementation OSMModel {
    NSMutableDictionary *_nodes, *_ways, *_relations;
    NSMutableSet *_highways;
    NSMutableSet *_buildings;
    NSOrderedSet *_orderedWays;
}

- (instancetype)init {
    if ((self = [super init])) {
        _nodes = [[NSMutableDictionary alloc] initWithCapacity:1000];
        _ways = [[NSMutableDictionary alloc] initWithCapacity:100];
        _relations = [[NSMutableDictionary alloc] initWithCapacity:100];
//        _orderedWays = [[NSMutableOrderedSet alloc] initWithCapacity:100];
//        _highways = [NSMutableSet set];
        
        [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"accessibilityLevel" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (OSMElement *)elementWithId:(OSMIdentifier *)osmid {
    return self.relations[osmid] ? self.relations[osmid]
    : self.ways[osmid] ? self.ways[osmid]
    : self.nodes[osmid] ? self.nodes[osmid]
    : self.relations[osmid] ? self.relations[osmid]
    : nil;
}

- (void)addNode:(OSMNode *)node {
    [_nodes setObject:node forKey:node.osmid];
}

- (void)addWay:(OSMWay *)way {
    [_ways setObject:way forKey:way.osmid];
    _orderedWays = nil;
}

- (void)addRelation:(OSMRelation *)relation {
    [_relations setObject:relation forKey:relation.osmid];
}

- (NSOrderedSet *)orderedWays {
    if (!_orderedWays) {
       // NSSortDescriptor *waySortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"zIndex" ascending:YES];
        _orderedWays = [NSOrderedSet orderedSetWithArray:
                        [self.ways keysSortedByValueUsingComparator:^NSComparisonResult(OSMWay* way1, OSMWay* way2) {
                            return [[NSNumber numberWithInteger:way1.zIndex] compare:[NSNumber numberWithInteger:way2.zIndex]];
                        }]];
    }
    return _orderedWays;
}

- (NSSet *)buildings {
    if (!_buildings) {
        // Create OSMBuilding objects
        _buildings = [NSMutableSet set];
        for (OSMWay* way in [self.ways allValues]) {
            if (way.isBuilding) {
                OSMBuilding *building = [[OSMBuilding alloc] initWithWay:way];
                if (building)
                    [_buildings addObject:building];
            }
        }
    }
    return _buildings;
}

- (NSSet*) highways {
    if (!_highways) {
        _highways = [NSMutableSet set];
        for (OSMWay *way in [self.ways allValues]) {
            if (way.isNavigable)
                [_highways addObject:way];
        }
    }
    return _highways;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [NSUserDefaults standardUserDefaults]) {
        if ([keyPath isEqualToString:@"accessibilityLevel"]) {
            _highways = nil;
        }
    }
}

@end
