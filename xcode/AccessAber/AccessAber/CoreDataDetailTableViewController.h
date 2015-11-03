//
//  CoreDataDetailTableViewController.h
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataDetailTableViewController : UITableViewController

@property (nonatomic) NSManagedObject* managedObject;

@end
