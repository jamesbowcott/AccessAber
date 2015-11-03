#import "OSMBuilding.h"

@implementation OSMBuilding

#pragma mark - Initialisers

- (instancetype)initWithWay:(OSMWay *)way {
    if ((self = [self init])) {
        self.outdoorWay = way;
        for (OSMRelation* relation in way.parents) {
            if ([[relation.tags[@"type"] lowercaseString] isEqualToString:@"building"])
                self.relation = relation;
        }
    }
    return self;
}

- (instancetype)initWithRelation:(OSMRelation *)relation outdoorWay:(OSMWay *)outdoorWay {
    if ((self = [self init])) {
        self.outdoorWay = outdoorWay;
        self.relation = relation;
    }
    return self;
}

#pragma mark - Properties

#pragma mark Setters

- (void)setRelation:(OSMRelation *)relation {
    if ([[relation.tags[@"type"] lowercaseString] isEqualToString:@"building"] &&
        [relation.members containsObject:self.outdoorWay]) {
        _relation = relation;
    } else {
        return;
        //LogError(@"Relation does not have correct tags or members");
    }
}

#pragma mark Getters

- (NSString *)name {
    if (self.relation && self.relation.tags[@"name"])
        return self.relation.tags[@"name"];
    else
        return self.outdoorWay.tags[@"name"];
}

- (bool)hasIndoor {
    return (self.relation != nil);
}

- (NSInteger)minLevel {
    if (self.relation && self.relation.tags[@"min_level"]) {
        return [self.relation.tags[@"min_level"] integerValue];
    } else {
        return 0;
    }
}

- (NSInteger)maxLevel {
    if (self.relation && self.relation.tags[@"max_level"]) {
        return [self.relation.tags[@"max_level"] integerValue];
    } else {
        return 0;
    }
}

- (bool)hasLevel:(NSInteger)level {
    return (level >= self.minLevel && level <= self.maxLevel && [self relationForLevel:level]);
}

- (OSMRelation*)relationForLevel:(NSInteger)level {
    if (self.relation) {
        for (OSMElement* element in self.relation.members) {
            if ([element isKindOfClass:[OSMRelation class]]) {
                OSMRelation *levelRelation = (OSMRelation*)element;
                if (levelRelation.tags[@"level"]) {
                    if ([levelRelation.tags[@"level"] integerValue] == level)
                        return levelRelation;
                }
            }
        }
    }
    return nil;
}

- (NSString*)nameForLevel:(NSInteger)level {
    OSMRelation *levelRelation = [self relationForLevel:level];
    if (levelRelation ) {
        return levelRelation.tags[@"level_name"];
    } else {
        return nil;
    }
}

- (NSOrderedSet *)indoorWaysForLevel:(NSInteger)level {
    if (self.relation) {
        NSMutableOrderedSet *indoorWays = [NSMutableOrderedSet orderedSet];
        
        for (OSMElement *element in [self relationForLevel:level].allMembers) {
            if ([element isKindOfClass:[OSMWay class]] &&
                //[element.tags[@"level"] integerValue] == level &&
                !element.tags[@"building"]) {
                [indoorWays addObject:element];
            }
        }
        
        return [NSOrderedSet orderedSetWithOrderedSet:indoorWays];
    } else {
        return nil;
    }
}

- (NSSet*)buildingWaysForLevel:(NSInteger)level {
    OSMRelation *levelRelation = [self relationForLevel:level];
    
    if (levelRelation) {
        NSMutableSet *buildingWays = [NSMutableSet set];
        
        for (OSMElement* element in levelRelation.members) {
            if ([element isKindOfClass:[OSMWay class]] &&
                element.tags[@"building"]) {
                [buildingWays addObject:element];
            }
        }
        
        return [NSSet setWithSet:buildingWays];
    } else {
        return nil;
    }
}


@end
