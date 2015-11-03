#import "Static.h"
#import "Info.h"
#import "StaticViewController.h"

@interface Static ()

// Private interface goes here.

@end

@implementation Static

+ (instancetype)objectForKey:(NSString*)key inContext:(NSManagedObjectContext*)context {
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:self.entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
    NSArray* results = [context executeFetchRequest:request error:nil];
    if (results.count == 1) {
        return results[0];
    } else {
        return nil;
    }
}

- (Info *)info {
//    return [self valueForKey:@"info"];
    return [self primitiveValueForKey:@"info"];
}

- (void)setInfo:(Info *)info {
//    [self setValue:info forKey:@"info"];
    [self setPrimitiveValue:info forKey:@"info"];
}

- (NSString*)name {
    if (self.info && self.info.name)
        return (NSString*)self.info.name;
    else
        return self.key;
}

- (Class)detailViewControllerClass {
    return [StaticViewController class];
}

@end
