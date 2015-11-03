//
//  MapAnnotation.m
//  AccessAber
//
//  Created by James on 01/05/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [self init])) {
        _coordinate = coordinate;
    }
    return self;
}

@end
