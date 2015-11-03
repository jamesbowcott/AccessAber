//
//  OSMRelation.m
//  AccessAber
//
//  Created by James on 24/04/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "OSMRelation.h"

@implementation OSMRelation {
    NSMutableOrderedSet *_members;
}

- (NSOrderedSet *)members {
    return [NSOrderedSet orderedSetWithOrderedSet:_members];
}

- (instancetype)init {
    if ((self = [super init])) {
        _members = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags members:(NSOrderedSet *)members {
    if ((self = [self initWithId:osmid tags:tags])) {
        if (members)
            _members = [NSMutableOrderedSet orderedSetWithOrderedSet:members];
        else
            _members = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (void)addMember:(OSMElement *)member {
    [_members addObject:member];
    [member addParent:self];
}

- (void)addMembers:(NSOrderedSet *)members {
    for (OSMElement *member in members) {
        [self addMember:member];
    }
}

- (void)removeMember:(OSMElement *)member {
    [_members removeObject:member];
    [member removeParent:self];
}

- (void)removeMembers:(NSSet *)members {
    for (OSMElement *member in members) {
        [self removeMember:member];
    }
}

- (void)setTags:(NSMutableDictionary *)tags {
    [super setTags:tags];
}

- (NSOrderedSet *)allMembers {
    NSMutableOrderedSet *allMembers = [NSMutableOrderedSet orderedSet];
    for (OSMElement *member in self.members) {
        if ([member isKindOfClass:[OSMRelation class]]) {
            for (OSMElement *submember in ((OSMRelation*)member).allTags) {
                [allMembers addObject:submember];
            }
        } else {
            [allMembers addObject:member];
        }
    }
    return [NSOrderedSet orderedSetWithOrderedSet:allMembers];
}

@end
