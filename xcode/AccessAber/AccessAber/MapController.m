#import "MapController.h"
#import <objc/runtime.h>
#import "Application.h"

@interface MapController()
@property (nonatomic) NSMutableArray *indoorWays;
@property (nonatomic) NSMutableArray *indoorOverlays;
@end

@implementation MapController {
    NSOrderedSet *_outdoorWays;
}

- (instancetype)initWithOSMModel:(OSMModel *)osm {
    if ((self = [self init])) {
        self.mapView = [[MKMapView alloc] init];
        self.mapView.delegate = self.mapDelegate = [[MapViewDelegate alloc] init];
        self.osm = osm;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setupMapView];
        }];
    }
    return self;
}

- (void)setupMapView {
    [[Application sharedApplication] requestLocationServices];
    
    // Outdoor overlays
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlays:[self.outdoorOverlays array]];
}

- (OSMNode*)nearestHighwayNodeForLocation:(CLLocation*)location {
    __block CLLocationDistance closestDistance = CLLocationDistanceMax;
    __block OSMNode* closestNode = nil;
    __block OSMWay* closestWay = nil;
    __block id<MKOverlay> closestOverlay = nil;
    
    [self.highwayOverlays enumerateKeysAndObjectsUsingBlock:^(NSNumber* wayid, id<MKOverlay> overlay, BOOL *stop) {
        OSMWay *way = [MapController wayAssociatedWithOverlay:overlay];
        if (way.isNavigable) {
            for (OSMNode* node in way.nodes) {
                CLLocation *nodeLocation = [[CLLocation alloc] initWithCoordinate:node.coordinate altitude:0 horizontalAccuracy:0 verticalAccuracy:0 timestamp:[NSDate date]];
                CLLocationDistance distance = [location distanceFromLocation:nodeLocation];
                if (distance < closestDistance) {
                    closestDistance = distance;
                    closestNode = node;
                    closestWay = way;
                    closestOverlay = overlay;
                }
            }
        }
    }];
    
    //return @{@"node":closestNode, @"way":closestWay, @"overlay":closestOverlay};
    return closestNode;
}

- (void)showInteriorOfBuilding:(OSMBuilding*)building level:(NSInteger)level {
    if (building == nil || !building.hasIndoor) {
        [self hideBuildingInterior];
        return;
    }
    
    if (self.indoorOverlays)
        [self.mapView removeOverlays:self.indoorOverlays];
    
    if ([building hasLevel:level]) {
        if (![self.mapView.overlays containsObject:self.mapDelegate.shadeOverlay])
            [self.mapView addOverlay:self.mapDelegate.shadeOverlay];
        
        self.indoorWays = [NSMutableArray array];
        [self.indoorWays addObjectsFromArray:[[building buildingWaysForLevel:level] allObjects]];
        [self.indoorWays addObjectsFromArray:[[building indoorWaysForLevel:level] array]];

        self.indoorOverlays = [NSMutableArray arrayWithCapacity:self.indoorWays.count];
        for (OSMWay* way in self.indoorWays) {
            id<MKOverlay> overlay = [MapController overlayForWay:way];
            [self.indoorOverlays addObject:overlay];
        }
        
        if (self.mapDelegate.routeOverlay) {
            [self.mapView removeOverlay:self.mapDelegate.routeOverlay];
            [self.mapView addOverlays:self.indoorOverlays];
            [self.mapView addOverlay:self.mapDelegate.routeOverlay];
        } else {
            [self.mapView addOverlays:self.indoorOverlays];
        }
        
        _indoorLevel = level;
        [self didChangeValueForKey:@"indoorLevel"];

        if (building != _indoorBuilding) {
            [self willChangeValueForKey:@"indoorBuilding"];
            _indoorBuilding = building;
            [self didChangeValueForKey:@"indoorBuilding"];
        }

    }
    
    return;
}

- (void)hideBuildingInterior {
    if (self.indoorOverlays) {
        [self.mapView removeOverlays:self.indoorOverlays];
        self.indoorOverlays = nil;
    }
    if (self.indoorWays) {
        self.indoorWays = nil;
    }
    [self.mapView removeOverlay:self.mapDelegate.shadeOverlay];
    [self willChangeValueForKey:@"indoorBuilding"];
    _indoorBuilding = nil;
    [self didChangeValueForKey:@"indoorBuilding"];
    [self willChangeValueForKey:@"indoorLevel"];
    _indoorLevel = 0;
    [self didChangeValueForKey:@"indoorLevel"];
}

- (void)setIndoorLevel:(NSInteger)indoorLevel {
    [self showInteriorOfBuilding:self.indoorBuilding level:indoorLevel];
}

- (void)setIndoorBuilding:(OSMBuilding *)indoorBuilding {
    [self showInteriorOfBuilding:indoorBuilding level:self.indoorLevel];
}

#pragma mark - Properties

- (NSOrderedSet *)outdoorWays {
    if (!_outdoorWays) {
        NSMutableOrderedSet *outdoorWays = [[NSMutableOrderedSet alloc] initWithCapacity:self.osm.orderedWays.count];
        for (OSMIdentifier *wayId in self.osm.orderedWays) {
            OSMWay *way = self.osm.ways[wayId];
            if (!way.isIndoor && !(way.isBuilding && way.tags[@"level"])) {
                [outdoorWays addObject:way];
            }
        }
        _outdoorWays = [NSOrderedSet orderedSetWithOrderedSet:outdoorWays];
    }
    return _outdoorWays;
}

#pragma mark - Overlays

+ (id<MKOverlay>)overlayForWay:(OSMWay*)way {
    id <MKOverlay> overlay;
    NSUInteger nodesCount = way.nodes.count;
    CLLocationCoordinate2D coordinates[nodesCount];
    
    for (NSUInteger i = 0; i < nodesCount; i++) {
        coordinates[i] = ((OSMNode*)way.nodes[i]).coordinate;
    }
    
    if (way.isClosed) {
        overlay = [MKPolygon polygonWithCoordinates:coordinates count:nodesCount];
    } else {
        overlay = [MKPolyline polylineWithCoordinates:coordinates count:nodesCount];
    }
    
    // Associate OSMWay object with MKOverlay object
    objc_setAssociatedObject(overlay, @selector(wayAssociatedWithOverlay:), way, OBJC_ASSOCIATION_ASSIGN);
    
    return overlay;
}

+ (OSMWay *)wayAssociatedWithOverlay:(id<MKOverlay>)overlay {
    return objc_getAssociatedObject(overlay, @selector(wayAssociatedWithOverlay:));
}

- (NSMutableOrderedSet *)outdoorOverlays {
    if (!_outdoorOverlays) {
        _outdoorOverlays = [[NSMutableOrderedSet alloc] initWithCapacity:self.outdoorWays.count];
        _highwayOverlays = [[NSMutableDictionary alloc] init];
        _buildingOverlays = [[NSMutableDictionary alloc] init];
        
        for (OSMWay* way in self.outdoorWays) {
            id <MKOverlay> overlay = [MapController overlayForWay:way];
            
            if (way.isHighway) {
                _highwayOverlays[way.osmid] = overlay;
            } else if (way.isBuilding) {
                _buildingOverlays[way.osmid] = overlay;
            }
            
            [_outdoorOverlays addObject:overlay];
        }
    }
    return _outdoorOverlays;
}

- (OSMBuilding *)focusedBuilding {
    for (id<MKOverlay> overlay in [self.buildingOverlays allValues]) {
        if (MKMapRectContainsPoint([overlay boundingMapRect], MKMapPointForCoordinate(self.mapView.centerCoordinate))) {
            for (OSMBuilding* building in self.osm.buildings) {
                if (building.outdoorWay == [MapController wayAssociatedWithOverlay:overlay]) {
                    return building;
                }
            }
        }
    }
    return nil;
}

- (void)setRoute:(OSMRoute *)route {
    [self willChangeValueForKey:@"route"];
    _route = route;
    if (self.mapDelegate.routeOverlay) {
        [self.mapView removeOverlay:self.mapDelegate.routeOverlay];
    }
    self.mapDelegate.routeOverlay = [MapController overlayForWay:route];
    [self.mapView addOverlay:self.mapDelegate.routeOverlay];
    [self didChangeValueForKey:@"route"];
}

- (BOOL)setRouteFromCurrentLocationToCoordinate:(CLLocationCoordinate2D)coordinate {
    CLLocation *currentLocation = [Application sharedApplication].locationManager.location;
    if (currentLocation) {
        OSMNode *sourceNode = [self nearestHighwayNodeForLocation:currentLocation];
        CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        OSMNode *targetNode = [self nearestHighwayNodeForLocation:targetLocation];
        if (sourceNode && targetNode) {
            OSMRoute *route = [OSMRoute shortestRouteInModel:self.osm fromNode:sourceNode toNode:targetNode];
            if (route ) {
                self.route = route;
                return YES;
            }
        }
    }
    return NO;
}

@end


# pragma mark - C helper functions

bool IsRegionInsideRegion(MKCoordinateRegion parent, MKCoordinateRegion child) {
    return ((child.center.latitude <= (parent.center.latitude + (parent.span.latitudeDelta/2.0))) &&
            (child.center.latitude >= (parent.center.latitude - (parent.span.latitudeDelta/2.0))) &&
            (child.center.longitude <= (parent.center.longitude + (parent.span.longitudeDelta/2.0))) &&
            (child.center.longitude >= (parent.center.longitude - (parent.span.longitudeDelta/2.0))) &&
            (child.span.latitudeDelta <= parent.span.latitudeDelta) &&
            (child.span.longitudeDelta <= parent.span.longitudeDelta));
}

MKMapRect MapRectForCoordinateRegion(MKCoordinateRegion region) {
    MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude + region.span.latitudeDelta / 2,
                                                                      region.center.longitude - region.span.longitudeDelta / 2));
    MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude - region.span.latitudeDelta / 2,
                                                                      region.center.longitude + region.span.longitudeDelta / 2));
    return MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y));
}

