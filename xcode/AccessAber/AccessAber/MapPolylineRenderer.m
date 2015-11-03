#import "MapPolylineRenderer.h"
#import "MapController.h"

@implementation MapPolylineRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay {
    OSMWay *way = [MapController wayAssociatedWithOverlay:overlay];
    if (way) {
        if ((self = [super initWithOverlay:overlay])) {
            if (![MapWayStyle setStyleForRenderer:self forWay:way])
                return nil;
            
            // Steps
            if ([way.tags[@"highway"] isEqualToString:@"steps"]) {
                self.lineDashPattern = @[@1.0,@1.0];
                self.lineCap = kCGLineCapButt;
            }
        }
    }
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
//    static MKZoomScale lastZoomScale = 0.0;
//    if (zoomScale != lastZoomScale) {
//        LogDebug(@"Zoom scale %f", zoomScale);
//        lastZoomScale = zoomScale;
//    }
    
//    CGFloat lineWidth = self.lineWidth;
//    if (zoomScale < 0.1f) {
//        self.lineWidth = round(lineWidth * (zoomScale * 10.0f));
//    }
    //if (zoomScale * 10 * self.lineWidth >= 1.0)
    [super drawMapRect:mapRect zoomScale:zoomScale inContext:context];
//    self.lineWidth = lineWidth;
}

- (void)applyStrokePropertiesToContext:(CGContextRef)context atZoomScale:(MKZoomScale)zoomScale {
    [super applyStrokePropertiesToContext:context atZoomScale:fmaxf(0.1, fminf(0.5, zoomScale))];
}


@end
