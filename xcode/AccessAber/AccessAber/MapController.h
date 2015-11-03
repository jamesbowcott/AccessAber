#import <MapKit/MapKit.h>
#import "OSMModel.h"
#import "MapViewDelegate.h"
#import "OSMRoute.h"


@interface MapController : NSObject
@property (nonatomic) MKMapView *mapView;
@property (nonatomic) MapViewDelegate *mapDelegate;
@property (nonatomic) OSMModel *osm;

@property (nonatomic, readonly) NSOrderedSet *outdoorWays;

@property (nonatomic) NSMutableOrderedSet* outdoorOverlays;
@property (nonatomic) NSMutableDictionary* highwayOverlays;
@property (nonatomic) NSMutableDictionary* buildingOverlays;

@property (nonatomic) OSMBuilding *indoorBuilding;
@property (nonatomic) NSInteger indoorLevel;

@property (nonatomic, readonly) OSMBuilding *focusedBuilding;

@property (nonatomic) OSMRoute *route;

- (instancetype)initWithOSMModel:(OSMModel*)osm;

+ (id<MKOverlay>)overlayForWay:(OSMWay*)way;
+ (OSMWay*)wayAssociatedWithOverlay:(id<MKOverlay>)overlay;
//- (id<MKOverlay>)overlayForWay:(OSMWay*)way;

- (OSMNode*)nearestHighwayNodeForLocation:(CLLocation*)location;
- (void)showInteriorOfBuilding:(OSMBuilding*)building level:(NSInteger)level;
- (void)hideBuildingInterior;
- (BOOL)setRouteFromCurrentLocationToCoordinate:(CLLocationCoordinate2D)coordinate;

@end

bool IsRegionInsideRegion(MKCoordinateRegion parent, MKCoordinateRegion child);
MKMapRect MapRectForCoordinateRegion(MKCoordinateRegion region);
