#import "MapViewDelegate.h"
#import "MapPolygonRenderer.h"
#import "MapPolylineRenderer.h"
#import "MapAnnotation.h"
#import "MapController.h"
#import "Application.h"

@interface MapViewDelegate()
@end

@implementation MapViewDelegate

- (MKCoordinateRegion)boundingRegion {
    return MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(52.415, -4.060), 1550.0*1.5, 1500.0*3.0);
}

- (MKCoordinateRegion)defaultRegion {
    return MKCoordinateRegionMake(CLLocationCoordinate2DMake(52.417405, -4.064603), MKCoordinateSpanMake(0.009254, 0.010671));
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //LogDebug(@"mapView regionDidChange: region.center = %f %f  region.span = %f %f", mapView.region.center.latitude, mapView.region.center.longitude, mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
    if (!IsRegionInsideRegion(self.boundingRegion, mapView.region)) {
        [mapView setRegion:self.defaultRegion animated:YES];
    }
    
    // Show focused building interior if zoomed in enough
    if (mapView.region.span.longitudeDelta < 0.003) {
        OSMBuilding* focusedBuilding = [Application sharedApplication].mapController.focusedBuilding;
        if (focusedBuilding && [[Application sharedApplication].mapController indoorBuilding] != focusedBuilding) {
            [[Application sharedApplication].mapController showInteriorOfBuilding:focusedBuilding level:0];
        }
    } else {
        [[Application sharedApplication].mapController hideBuildingInterior];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        if (overlay == self.shadeOverlay)
            return [self shadePolygonRenderer];
        else
            return [[MapPolygonRenderer alloc] initWithOverlay:overlay];
    } else if ([overlay isKindOfClass:[MKPolyline class]]) {
        return [[MapPolylineRenderer alloc] initWithOverlay:overlay];
    } else {
        return nil;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    else
        return [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
}

- (id<MKOverlay>)shadeOverlay {
    if (!_shadeOverlay) {
        CLLocationCoordinate2D coordinates[] = {
            CLLocationCoordinate2DMake(52.44, -4.1), CLLocationCoordinate2DMake(52.44, -4.0),
            CLLocationCoordinate2DMake(52.39, -4.0), CLLocationCoordinate2DMake(52.39, -4.1)
        };
        _shadeOverlay = [MKPolygon polygonWithCoordinates:coordinates count:4];
    }
    return _shadeOverlay;
}

- (MKPolygonRenderer*)shadePolygonRenderer {
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithOverlay:self.shadeOverlay];
    renderer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    return renderer;
}

#pragma mark - Location



@end
