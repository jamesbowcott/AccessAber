#import "Place.h"
#import "PlacesViewController.h"

@interface Place ()

// Private interface goes here.

@end

@implementation Place

+ (Class)detailViewControllerClass {
    return [PlacesViewController class];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latValue, self.lonValue);
}

@end
