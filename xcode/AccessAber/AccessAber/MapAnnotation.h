//
//  MapAnnotation.h
//  AccessAber
//
//  Created by James on 01/05/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
