//
//  MasterViewController.h
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSUInteger, MasterViewControllerEntity) {
    Departments,
    Buildings
};

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *entitySegmentedControl;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (nonatomic) MasterViewControllerEntity entity;
@property (nonatomic) NSString *entityName;

@end

