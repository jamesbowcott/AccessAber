//
//  MasterViewController.m
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "MasterViewController.h"
#import "StaticViewController.h"
#import "MultilingualString.h"
#import "Application.h"

@interface MasterViewController ()

@end

@implementation MasterViewController {
    NSString* _entityName;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext == nil) {
        return [Application sharedApplication].staticManagedObjectContext;
    } else {
        return _managedObjectContext;
    }
}

- (NSInteger)segmentIndexForEntityName:(NSString*)entityName {
    if ([entityName isEqualToString:@"Department"]) return 0;
    else if ([entityName isEqualToString:@"Building"]) return 1;
    else return -1;
}

- (void)setSelectedSegmentIndexForEntityName:(NSString*)entityName {
    if ([entityName isEqualToString:@"Department"])
        self.entitySegmentedControl.selectedSegmentIndex = 0;
    else if ([entityName isEqualToString:@"Building"])
        self.entitySegmentedControl.selectedSegmentIndex = 1;
    else
        self.entitySegmentedControl.selectedSegmentIndex = -1;
}

- (NSString*)entityNameForSelectedSegmentIndex {
    switch (self.entitySegmentedControl.selectedSegmentIndex) {
        case 0: return @"Department";
        case 1: return @"Building";
        default:
            [self.entitySegmentedControl setSelectedSegmentIndex:0];
            return [self entityNameForSelectedSegmentIndex];
    }
}

- (NSString *)entityName {
    if (!_entityName) {
        _entityName = [self entityNameForSelectedSegmentIndex];
    }
    return _entityName;
}

- (void)setEntityName:(NSString*)entityName {
    _entityName = entityName;
    
    if (self.entitySegmentedControl.selectedSegmentIndex != [self segmentIndexForEntityName:entityName])
        self.entitySegmentedControl.selectedSegmentIndex = [self segmentIndexForEntityName:entityName];

    [self.fetchedResultsController.fetchRequest setEntity:[self entityDescription]];
    [self updateData];
    [self.tableView reloadData];
}

- (NSEntityDescription*)entityDescription {
    return [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
}

- (IBAction)entitySegmentedControlChanged:(id)sender {
    if (self.entitySegmentedControl.selectedSegmentIndex != [self segmentIndexForEntityName:self.entityName])
        [self setEntityName:[self entityNameForSelectedSegmentIndex]];
    //self.title = [self.entitySegmentedControl titleForSegmentAtIndex:self.entitySegmentedControl.selectedSegmentIndex];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = [self.entitySegmentedControl titleForSegmentAtIndex:self.entitySegmentedControl.selectedSegmentIndex];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[MultilingualString stringWithDictionary:@{@"base":@"Back", @"cy":@"Dychwelyd"}] style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    ;
}

#pragma mark - Segues

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Static* object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (object) {
        StaticViewController *detailView = [[[[object class] detailViewControllerClass] alloc] init];
        detailView.detailItem = object;
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Static *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo name];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"key"] description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    //NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:[self entityDescription]];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"key" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"group.info.name.defaultString" cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [self updateData];
    
    return _fetchedResultsController;
}

- (void)updateData {
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}



@end
