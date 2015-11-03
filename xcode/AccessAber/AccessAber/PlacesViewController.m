#import "PlacesViewController.h"
#import "PlaceGroup.h"
#import "Application.h"

@implementation PlacesViewController {
    StaticViewControllerSection* routeSection;
    StaticViewControllerSection* placeGroupSection;
}

- (NSArray *)sections {
    NSMutableArray *sections = [NSMutableArray arrayWithArray:[super sections]];
    if (!routeSection) {
        routeSection = [StaticViewControllerSection sectionWithIdentifier:@"route"];
        routeSection.title = [MultilingualString stringWithDictionary:@{@"base":@"route"}];
    }
    if (!placeGroupSection) {
        placeGroupSection = [StaticViewControllerSection sectionWithIdentifier:@"placeGroup"];
        placeGroupSection.title = [MultilingualString stringWithDictionary:@{@"base":@"group"}];
    }
    [sections insertObject:routeSection atIndex:0];
    [sections insertObject:placeGroupSection atIndex:0];
    
     return [NSArray arrayWithArray:sections];
}

- (Place *)place {
    return (Place*)self.detailItem;
}

- (void)setPlace:(Place *)place {
    [self setDetailItem:place];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self indexOfSectionWithIdentifier:@"route"]) {
        return 0;
    } else if (section == [self indexOfSectionWithIdentifier:@"placeGroup"]) {
        return 1;
    } else {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"route"]) {
        return nil;
    } else if (indexPath.section == [self indexOfSectionWithIdentifier:@"placeGroup"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.place.group.name;
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.place && CLLocationCoordinate2DIsValid(self.place.coordinate)) {
        if ([[Application sharedApplication].mapController setRouteFromCurrentLocationToCoordinate:self.place.coordinate]) {
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

@end
