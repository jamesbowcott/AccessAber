//
//  Model.h
//  AccessAber
//
//  Created by James on 23/02/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Model : NSObject


+ (NSMutableArray*)createManagedObjectsFromRootDictionary:(NSDictionary*)rootDict inContext:(NSManagedObjectContext*)context;



@end
