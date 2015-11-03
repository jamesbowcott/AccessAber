//
//  OSMElement.m
//  AccessAber
//
//  Created by James on 24/04/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "OSMElement.h"

@implementation OSMElement {
    NSMutableSet *_parents;
}

- (instancetype)init {
    if ((self = [super init])) {
        _parents = [NSMutableSet set];
    }
    return self;
}

- (instancetype)initWithId:(NSNumber *)osmid {
    if ((self = [self init])) {
        _osmid = osmid;
    }
    return self;
}

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags {
    if ((self = [self initWithId:osmid])) {
        _tags = [NSMutableDictionary dictionaryWithDictionary:tags];
    }
    return self;
}

- (NSMutableDictionary *)tags {
    if (!_tags) {
        _tags = [NSMutableDictionary dictionary];
    }
    return _tags;
}

- (NSDictionary *)allTags {
    NSMutableDictionary* tags = [NSMutableDictionary dictionary];
    for (OSMElement* parent in self.parents) {
        [tags addEntriesFromDictionary:parent.allTags];
    }
    [tags addEntriesFromDictionary:self.tags];
    return tags;
}

- (NSSet *)parents {
    return [NSSet setWithSet:_parents];
}

- (void)addParent:(OSMRelation*)parent {
    [_parents addObject:parent];
}

- (void)removeParent:(OSMRelation *)relation {
    [_parents removeObject:relation];
}

@end
