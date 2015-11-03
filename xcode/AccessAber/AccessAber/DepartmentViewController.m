//
//  DepartmentViewController.m
//  AccessAber
//
//  Created by jab41 on 27/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "DepartmentViewController.h"
#import "Place.h"
#import "Building.h"
#import "PlacesViewController.h"
#import "Application.h"

@interface DepartmentViewController ()

@end

@implementation DepartmentViewController {
    StaticViewControllerSection* placeSection;
}

- (Department *)department {
    return (Department*)self.detailItem;
}

- (void)setDepartment:(Department *)department {
    [self setDetailItem:department];
}

- (NSArray *)sections {
    if (!placeSection) {
        placeSection = [StaticViewControllerSection sectionWithIdentifier:@"places"];
        placeSection.title = [MultilingualString stringWithDictionary:@{@"base":@"Places"}];
    }
    NSMutableArray* sections = [NSMutableArray arrayWithArray:[super sections]];
    [sections insertObject:placeSection atIndex:0];
    return [NSArray arrayWithArray:sections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self indexOfSectionWithIdentifier:@"places"])
        return self.department.places.count;
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"places"]) {
        Place *place = [self.department.places objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlaceCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = place.name;
        cell.detailTextLabel.text = place.building.name;
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"places"]) {
        Place *place = [self.department.places objectAtIndex:indexPath.row];
        PlacesViewController* vc = [[PlacesViewController alloc] init];
        vc.place = place;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
