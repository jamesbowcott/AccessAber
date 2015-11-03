//
//  MainMapViewController.m
//  AccessAber
//
//  Created by James on 03/05/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "MainMapViewController.h"
#import "Application.h"

@interface MainMapViewController ()
@property (nonatomic) MKMapView *mapView;
@property (nonatomic, readonly) MapController *mapController;
@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /* When the view appears, we need to add the shared MKMapView to the view,
     and set it to use anything unique to this view */
    self.mapView = [Application sharedApplication].mapController.mapView;
    // If mapView is still part of another view, remove it from it's superview
    if (self.mapView.superview)
        [self.mapView removeFromSuperview];
    self.mapView.frame = self.view.frame;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    [self.mapController addObserver:self forKeyPath:@"indoorBuilding" options:NSKeyValueObservingOptionNew context:NULL];
    [self.mapController addObserver:self forKeyPath:@"indoorLevel" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // Unconfigure the shared MKMapView to anything specific to this view
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (MapController *)mapController {
    return [Application sharedApplication].mapController;
}

- (IBAction)debugbutton:(id)sender {
    OSMBuilding *building;
    for (OSMBuilding *b in [Application sharedApplication].mapController.osm.buildings) {
        if (b.hasIndoor) {
            if ([b.relation.tags[@"name"] isEqualToString:@"Llandinam Building"]) {
                building = b;
                break;
            }
        }
    }
    if (!building)
        return;
    
    [[Application sharedApplication].mapController showInteriorOfBuilding:building level:0];

}

- (void)updateIndoorLevelLabel {
    if (self.mapController.indoorBuilding) {
        self.indoorLevelLabel.text =
            [NSString stringWithFormat:@"Floor %@", [self.mapController.indoorBuilding nameForLevel:self.mapController.indoorLevel]];
    } else {
        self.indoorLevelLabel.text = @"";
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.mapController) {
        if ([keyPath isEqualToString:@"indoorBuilding"]) {
            if (self.mapController.indoorBuilding != nil) {
                self.indoorLevelStepper.minimumValue = self.mapController.indoorBuilding.minLevel;
                self.indoorLevelStepper.maximumValue = self.mapController.indoorBuilding.maxLevel;
                self.indoorLevelStepper.value = self.mapController.indoorLevel;
                [self updateIndoorLevelLabel];
                [self.indoorControlsView setHidden:NO];
            } else {
                [self.indoorControlsView setHidden:YES];
            }
        } else if ([keyPath isEqualToString:@"indoorLevel"]) {
            [self updateIndoorLevelLabel];
        }
    }
}

- (IBAction)indoorLevelStepperChanged:(id)sender {
    self.mapController.indoorLevel = (NSInteger)self.indoorLevelStepper.value;
}

@end
