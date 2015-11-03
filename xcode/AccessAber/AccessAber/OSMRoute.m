#import "OSMRoute.h"

@implementation OSMRoute

- (instancetype)initWithNodes:(NSArray *)nodes {
    if ((self = [self initWithId:nil tags:@{@"route":@"yes"} nodes:nodes])) {
        
    }
    return self;
}

- (NSInteger)zIndex {
    return NSIntegerMax;
}

#pragma mark - Routing algorithm

+ (NSDictionary*)allHighwayNodesInModel:(OSMModel*)model {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for (OSMWay* way in model.highways) {
        for (OSMNode* node in way.nodes)
            dict[node.osmid] = node;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (OSMNode*)closestNodeToNode:(OSMNode*)node inSet:(NSSet*)intersectionSet {
    NSMutableSet* adjacentNodes = [NSMutableSet setWithSet:[node adjacentHighwayNodes]];
    [adjacentNodes intersectSet:intersectionSet];
    CLLocationDistance shortestDistance = CLLocationDistanceMax;
    OSMNode* closestNode = nil;
    
    for (OSMNode* adjacentNode in adjacentNodes) {
        CLLocationDistance distance = [OSMNode distanceBetweenNodes:@[node, adjacentNode]];
        if (distance < shortestDistance) {
            shortestDistance = distance;
            closestNode = adjacentNode;
        }
    }
    
    return closestNode;
}

// http://en.wikipedia.org/wiki/Dijkstra's_algorithm
+ (OSMRoute *)shortestRouteInModel:(OSMModel*) model fromNode:(OSMNode *)startNode toNode:(OSMNode *)endNode {
    NSDictionary *allHighwayNodes = [OSMRoute allHighwayNodesInModel:model];
    if (!allHighwayNodes[startNode.osmid] || !allHighwayNodes[endNode.osmid])
        return nil;
    NSMutableArray *nodeQueue = [NSMutableArray arrayWithObject:startNode.osmid];
    NSMutableDictionary *nodeDistances = [NSMutableDictionary dictionaryWithCapacity:allHighwayNodes.count];
    NSMutableDictionary *previousNodes = [NSMutableDictionary dictionaryWithCapacity:allHighwayNodes.count];
    NSNumber *infinity = [NSNumber numberWithDouble:CLLocationDistanceMax];
    bool success = false;
    
    nodeDistances[startNode.osmid] = [NSNumber numberWithDouble:0];
    
    while (nodeQueue.count > 0) {
        // Sort the queue
        [nodeQueue sortUsingComparator:^NSComparisonResult(NSNumber *node1Id, NSNumber *node2Id) {
                NSNumber *node1Dist = nodeDistances[node1Id] ? nodeDistances[node1Id] : infinity;
                NSNumber *node2Dist = nodeDistances[node2Id] ? nodeDistances[node2Id] : infinity;
                return [node1Dist compare:node2Dist];
        }];
        
        NSNumber *nodeId = [nodeQueue firstObject];
        if ([nodeId isEqualToValue:endNode.osmid]) {
            success = true;
            break;
        }
        OSMNode *node = allHighwayNodes[nodeId];
        [nodeQueue removeObjectAtIndex:0];
        
        NSSet *adjacentNodes = [node adjacentHighwayNodes];
        for (OSMNode *neighbourNode in adjacentNodes) {
            NSNumber *alt = [NSNumber numberWithDouble: [nodeDistances[nodeId] doubleValue] + [OSMNode distanceBetweenNodes:@[node, neighbourNode]] ];
            if (!nodeDistances[neighbourNode.osmid] || [alt compare:nodeDistances[neighbourNode.osmid]] == NSOrderedAscending) {
                nodeDistances[neighbourNode.osmid] = alt;
                previousNodes[neighbourNode.osmid] = nodeId;
                if (![nodeQueue containsObject:neighbourNode.osmid])
                    [nodeQueue addObject:neighbourNode.osmid];
            }
        }
    
    }
    
    if (success) {
        NSMutableOrderedSet *routeNodes = [NSMutableOrderedSet orderedSet];
        NSNumber *currentNodeId = endNode.osmid;
        
        while (currentNodeId) {
            [routeNodes insertObject:allHighwayNodes[currentNodeId] atIndex:0];
            currentNodeId = previousNodes[currentNodeId];
        }
        
        return [[OSMRoute alloc] initWithNodes:[routeNodes array]];
    } else {
        return nil;
    }
    
}

@end
