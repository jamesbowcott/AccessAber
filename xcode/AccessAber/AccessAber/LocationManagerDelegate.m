//
//  LocationManagerDelegate.m
//  AccessAber
//
//  Created by James on 08/05/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "LocationManagerDelegate.h"
#import "Application.h"

@implementation LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [Application sharedApplication].mapController.mapView.showsUserLocation = YES;
        [manager startUpdatingLocation];
    }
}

@end
