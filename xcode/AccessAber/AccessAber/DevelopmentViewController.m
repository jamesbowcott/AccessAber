//
//  DevelopmentViewController.m
//  AccessAber
//
//  Created by James on 27/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "DevelopmentViewController.h"
#import "CoreDataBrowserTableViewController.h"

@interface DevelopmentViewController ()

@end

@implementation DevelopmentViewController

- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL deselect = NO;
    
    if ([cell.reuseIdentifier isEqualToString:@"coredatabrowser"]) {
        CoreDataBrowserTableViewController* vc = [[CoreDataBrowserTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.reuseIdentifier isEqualToString:@"ResetUserDefaults"]) {
        [self resetDefaults];
//        [[[UIAlertView alloc] initWithTitle:@"User Defaults reset" message:@"App may need to be quit for all changes to take effect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        deselect = YES;
    }
    
    if (deselect)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)resetDefaults {
    LogWarning(@"Removing all objects from user defaults");
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    for (NSString* key in [defs dictionaryRepresentation]) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

@end
