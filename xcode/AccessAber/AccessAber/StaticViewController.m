//
//  StaticViewController.m
//  AccessAber
//
//  Created by James on 24/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "StaticViewController.h"
#import "Info.h"
#import "MultilingualString.h"

@implementation StaticViewControllerSection
+ (instancetype)sectionWithIdentifier:(NSString *)identifier {
    StaticViewControllerSection *section = [[StaticViewControllerSection alloc] init];
    section.identifier = identifier;
    return section;
}
@end


@interface StaticViewController ()
@property (readonly) Info* infoItem;
@end

@implementation StaticViewController {
    NSArray* _sections;
}

- (NSArray *)sections {
    if (!_sections) {
        StaticViewControllerSection *infoSection = [StaticViewControllerSection sectionWithIdentifier:@"info"];
        infoSection.title = [MultilingualString stringWithDictionary:@{@"base":@"Information"}];
        _sections = [NSArray arrayWithObject:infoSection];
    }
    return _sections;
}

- (StaticViewControllerSection *)section:(NSInteger)section {
    return (StaticViewControllerSection*)[self.sections objectAtIndex:section];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return ((self = [super initWithStyle:UITableViewStyleGrouped]));
}


- (Info *)infoItem {
    return [self.detailItem valueForKey:@"info"];
}

- (void)setDetailItem:(Static *)detailItem {
    _detailItem = detailItem;
    [self configureView];
}

- (NSInteger)indexOfSectionWithIdentifier:(NSString*)identifier {
    for (int i = 0; i < self.sections.count; i++) {
        StaticViewControllerSection *section = self.sections[i];
        if ([section.identifier isEqualToString:identifier])
            return i;
    }
    return -1;
}

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)configureView {
    self.title = self.detailItem.name;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self indexOfSectionWithIdentifier:@"info"])
        return self.infoItem.viewableProperties.count;
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"info"]) {
        UITableViewCell *cell;
        NSPropertyDescription *property = self.detailItem.info.viewableProperties[indexPath.row];
        
        if ([property isKindOfClass:[NSRelationshipDescription class]]
            && ![[(NSRelationshipDescription*)property destinationEntity].name isEqualToString:@"MultilingualString"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellDisclosure"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellDisclosure"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellDetail"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellDetail"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.detailTextLabel.text = [self.infoItem nameForPropertyNamed:property.name];
        }
        
        cell.textLabel.text = [self.detailItem.info valueForKey:property.name];
        
        return cell;
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self tableView:tableView numberOfRowsInSection:section] > 0) {
        if (self.sections[section]) {
            return (NSString*)[self section:section].title;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self indexOfSectionWithIdentifier:@"info"]) {
        //
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
