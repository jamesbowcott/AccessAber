#import "Department.h"
#import "DepartmentViewController.h"

@interface Department ()

// Private interface goes here.

@end

@implementation Department

+ (Class)detailViewControllerClass {
    return [DepartmentViewController class];
}

@end
