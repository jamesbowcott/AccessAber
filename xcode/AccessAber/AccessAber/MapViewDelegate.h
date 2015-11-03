#import <MapKit/MapKit.h>

@interface MapViewDelegate : NSObject <MKMapViewDelegate>

@property (nonatomic, readonly) MKCoordinateRegion boundingRegion;
@property (nonatomic, readonly) MKCoordinateRegion defaultRegion;
@property (nonatomic) id<MKOverlay> shadeOverlay;
@property (nonatomic) id<MKOverlay> routeOverlay;

@end
