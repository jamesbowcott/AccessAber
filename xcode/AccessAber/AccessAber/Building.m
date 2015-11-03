#import "Building.h"
#import "BuildingViewController.h"
@interface Building ()

// Private interface goes here.

@end

@implementation Building

+ (Class)detailViewControllerClass {
    return [BuildingViewController class];
}

@end
