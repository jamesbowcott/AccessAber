//
//  Application.m
//  AccessAber
//
//  Created by James on 27/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "Application.h"
#import "AppDelegate.h"
#import "OSMXMLParser.h"
#import "Model.h"
#import "LocationManagerDelegate.h"

static NSString* kUDAccessibilityLevel = @"accessibilityLevel";

@implementation Application {
    CLLocationManager *_locationManager;
    LocationManagerDelegate *_locationManagerDelegate;
}

- (instancetype)init
{
    if ((self = [super init])) {
        
        // Core Data model
        NSDate *populateTimeStart = [NSDate date];
        [Model createManagedObjectsFromRootDictionary: [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"static" withExtension:@"plist"]]
                                            inContext: ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext];
        NSDate *populateTimeEnd = [NSDate date];
        NSLog(@"Static store population took %f seconds", [populateTimeEnd timeIntervalSinceDate:populateTimeStart]);
        
        
        // OSM model
        self.osm = [[OSMModel alloc] init];
        OSMXMLParser *osmParser = [[OSMXMLParser alloc] initWithOSMFile:[[NSBundle mainBundle] URLForResource:@"penglais2" withExtension:@"osm"] forModel:self.osm];
        [osmParser parse];
        
        // Map
        self.mapController = [[MapController alloc] initWithOSMModel:self.osm];
        
    }
    return self;
}

+ (instancetype)sharedApplication {
    static Application *sharedApplication = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApplication = [[self alloc] init];
    });
    return sharedApplication;
}

#pragma mark - Properties

- (NSUInteger)accessibilityLevel {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kUDAccessibilityLevel];
}

- (void)setAccessibilityLevel:(NSUInteger)accessibilityLevel {
    [[NSUserDefaults standardUserDefaults] setInteger:accessibilityLevel forKey:kUDAccessibilityLevel];
}

- (NSManagedObjectContext *)staticManagedObjectContext {
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManagerDelegate = [[LocationManagerDelegate alloc] init];
        _locationManager.delegate = _locationManagerDelegate;
    }
    return _locationManager;
}

# pragma mark -

- (BOOL)requestLocationServices {
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusRestricted || authStatus == kCLAuthorizationStatusDenied) {
        return NO;
    } else {
        if (authStatus == kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        } else {
            self.mapController.mapView.showsUserLocation = YES;
            [self.locationManager startUpdatingLocation];
        }
        return YES;
    }
}

@end
