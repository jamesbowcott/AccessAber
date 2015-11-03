//
//  StaticViewController.h
//  AccessAber
//
//  Created by James on 24/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Static.h"
#import "MultilingualString.h"


@interface StaticViewControllerSection : NSObject
@property (nonatomic) NSString* identifier;
@property (nonatomic) MultilingualString* title;

+ (instancetype)sectionWithIdentifier:(NSString*)identifier;
@end

@interface StaticViewController : UITableViewController

@property (nonatomic) Static* detailItem;
@property (nonatomic) NSArray* sections;

- (NSInteger)indexOfSectionWithIdentifier:(NSString*)identifier;
- (StaticViewControllerSection*)section:(NSInteger)section;

@end
