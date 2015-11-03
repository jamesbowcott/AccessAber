#import "MapPolygonRenderer.h"
#import "MapController.h"

@implementation MapPolygonRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay {
    OSMWay *way = [MapController wayAssociatedWithOverlay:overlay];
    if (way) {
        if ((self = [super initWithOverlay:overlay])) {
            if (![MapWayStyle setStyleForRenderer:self forWay:way])
                return nil;
        }
    }
    return self;
}

@end
