//
//  BuildingStaticViewController.m
//  AccessAber
//
//  Created by jab41 on 24/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "BuildingViewController.h"
#import "MultilingualString.h"
#import "Place.h"
#import "PlacesViewController.h"
#import "Application.h"

@implementation BuildingViewController

- (NSArray *)sections {
    NSMutableArray *sections = [NSMutableArray arrayWithArray:[super sections]];
    StaticViewControllerSection* placesSection = [[StaticViewControllerSection alloc] init];
    placesSection.identifier = @"places";
    placesSection.title = [MultilingualString stringWithDictionary:@{@"base":@"Places"}];
    [sections insertObject:placesSection atIndex:0];
    
    StaticViewControllerSection *routeSection = [[StaticViewControllerSection alloc] init];
    routeSection.identifier = @"route";
    [sections insertObject:routeSection atIndex:0];
    
    return [NSArray arrayWithArray:sections];
}


- (Building *)building {
    return (Building*)self.detailItem;
}

- (void)setBuilding:(Building *)building {
    [self setDetailItem:building];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self indexOfSectionWithIdentifier:@"places"])
        return self.building.places.count;
    else if (section == [self indexOfSectionWithIdentifier:@"route"])
        return 1;
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"places"]) {
        Place *place = [self.building.places.allObjects objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlaceCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = place.name;
        if (place.floor)
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Floor %@", place.floor];
        else
            cell.detailTextLabel.text = nil;
        
        return cell;
    } else if (indexPath.section == [self indexOfSectionWithIdentifier:@"route"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"Route";
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"places"]) {
        PlacesViewController* vc = [[PlacesViewController alloc] init];
        vc.place = [self.building.places.allObjects objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == [self indexOfSectionWithIdentifier:@"route"]) {
        OSMWay *buildingWay = [[Application sharedApplication].osm elementWithId:self.building.osmWay];
        if (buildingWay) {
            id<MKOverlay> overlay = [MapController overlayForWay:buildingWay];
            if ([[Application sharedApplication].mapController setRouteFromCurrentLocationToCoordinate:[overlay coordinate]]) {
                self.tabBarController.selectedIndex = 0;
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
