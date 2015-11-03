//
//  MapViewReuseTestViewController.m
//  AccessAber
//
//  Created by James on 27/04/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "MapViewReuseTestViewController.h"
#import "Application.h"

@interface MapViewReuseTestViewController ()
@property (nonatomic) MKMapCamera *camera;
@property (nonatomic) MKCoordinateRegion region;
@property (nonatomic) MKMapView *mapView;
@end

@implementation MapViewReuseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKCoordinateRegion)region {
    if (!CLLocationCoordinate2DIsValid(_region.center)) {
        _region = self.mapView.region;
    }
    return _region;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mapView = [Application sharedApplication].mapController.mapView;
    if (self.mapView.superview)
        [self.mapView removeFromSuperview];
    [self.mapView setFrame:self.targetView.bounds];
    
    if (!self.camera)
        self.camera = [self.mapView.camera copy];
    
    
    [self.mapView setCamera:self.camera];
    self.mapView.region = self.region;
    
    [self.targetView addSubview:self.mapView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.camera = [self.mapView.camera copy];
    self.region = self.mapView.region;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

@end
