//
//  CoreDataBrowserTableViewController.m
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "CoreDataBrowserTableViewController.h"
#import "CoreDataDetailTableViewController.h"
#import "Static.h"
#import "AppDelegate.h"
#import "MultilingualString.h"

@interface CoreDataBrowserTableViewController ()

@end

@implementation CoreDataBrowserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Root" style:UIBarButtonItemStylePlain target:self action:@selector(rootButtonTapped:)]];
}

- (void)rootButtonTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSManagedObjectModel*)managedObjectModel {
    // HACK!
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectModel;
}

- (NSManagedObjectContext*)managedObjectContext {
    // HACK!
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.managedObjects)
        return self.managedObjects.count;
    else
        return [self managedObjectModel].entities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.managedObjects) {
        NSManagedObject *managedObject = self.managedObjects[indexPath.row];
        if ([managedObject.entity isKindOfEntity:[NSEntityDescription entityForName:@"Static" inManagedObjectContext:managedObject.managedObjectContext]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", managedObject.entity.name, ((Static*)managedObject).key];
        } else if ([managedObject.entity isKindOfEntity:[MultilingualString entityInManagedObjectContext:managedObject.managedObjectContext]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", managedObject.entity.name, ((MultilingualString*)managedObject).defaultString];
        } else {
            cell.textLabel.text = managedObject.entity.name;
        }
    } else {
        NSEntityDescription *entity = [self managedObjectModel].entities[indexPath.row];
        cell.textLabel.text = entity.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.managedObjects) {
        CoreDataDetailTableViewController *vc = [[CoreDataDetailTableViewController alloc] init];
        vc.managedObject = self.managedObjects[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSEntityDescription *entity = [self managedObjectModel].entities[indexPath.row];
        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        CoreDataBrowserTableViewController *vc = [[CoreDataBrowserTableViewController alloc] init];
        vc.managedObjects = [[self managedObjectContext] executeFetchRequest:request error:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
