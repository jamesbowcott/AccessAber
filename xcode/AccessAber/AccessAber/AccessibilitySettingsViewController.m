//
//  AccessibilitySettingsViewController.m
//  AccessAber
//
//  Created by James on 27/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "AccessibilitySettingsViewController.h"
#import "Application.h"

static const NSUInteger kAccessibilityLevelSectionIndex = 0;

@interface AccessibilitySettingsViewController ()

@end

@implementation AccessibilitySettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) {
        case kAccessibilityLevelSectionIndex:
            if (indexPath.row == [Application sharedApplication].accessibilityLevel)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kAccessibilityLevelSectionIndex: {
            NSIndexPath* oldSelectedPath = [NSIndexPath indexPathForRow:[Application sharedApplication].accessibilityLevel inSection:kAccessibilityLevelSectionIndex];
            [tableView cellForRowAtIndexPath:oldSelectedPath].accessoryType = UITableViewCellAccessoryNone;
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            [Application sharedApplication].accessibilityLevel = indexPath.row;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //[tableView reloadData];
            break;
        }
        default:
            [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
