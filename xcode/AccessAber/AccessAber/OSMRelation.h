//
//  OSMRelation.h
//  AccessAber
//
//  Created by James on 24/04/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import "OSMElement.h"

@interface OSMRelation : OSMElement

@property (nonatomic, readonly) NSOrderedSet *members;
@property (nonatomic, readonly) NSOrderedSet *allMembers;

- (instancetype)initWithId:(NSNumber *)osmid tags:(NSDictionary *)tags members:(NSOrderedSet*)members;

- (void)addMembers:(NSOrderedSet*)members;
- (void)addMember:(OSMElement*)member;
- (void)removeMembers:(NSSet*)members;
- (void)removeMember:(OSMElement*)member;

@end
