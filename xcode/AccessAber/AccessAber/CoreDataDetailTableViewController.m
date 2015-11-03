//
//  CoreDataDetailTableViewController.m
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "CoreDataDetailTableViewController.h"
#import "CoreDataBrowserTableViewController.h"

@interface CoreDataDetailTableViewController ()

@end

@implementation CoreDataDetailTableViewController

- (NSString *)title {
    return self.managedObject.entity.name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Root" style:UIBarButtonItemStylePlain target:self action:@selector(rootButtonTapped:)]];
}

- (void)rootButtonTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.managedObject.entity.properties.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    }
    
    id property = self.managedObject.entity.properties[indexPath.row];
    if ([property isKindOfClass:[NSAttributeDescription class]]) {
        NSAttributeDescription *attribute = property;
        cell.textLabel.text = [NSString stringWithFormat:@"%@ = %@", attribute.name, [self.managedObject valueForKey:attribute.name]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if ([property isKindOfClass:[NSRelationshipDescription class]]) {
        NSRelationshipDescription *relationship = property;
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", relationship.name, relationship.isToMany ? @">>" : @">", relationship.destinationEntity.name];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.textLabel.text = [property description];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id property = self.managedObject.entity.properties[indexPath.row];
    if ([property isKindOfClass:[NSRelationshipDescription class]]) {
        NSRelationshipDescription *relationship = property;
        if (relationship.isToMany) {
            CoreDataBrowserTableViewController* vc = [[CoreDataBrowserTableViewController alloc] init];
            NSMutableArray *ma = [NSMutableArray array];
            [(NSSet*)[self.managedObject valueForKey:relationship.name] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                [ma addObject:obj];
            }];
            vc.managedObjects = [NSArray arrayWithArray:ma];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            CoreDataDetailTableViewController* vc = [[CoreDataDetailTableViewController alloc] init];
            vc.managedObject = [self.managedObject valueForKey:relationship.name];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
