#import "_Static.h"

@class Info;

@interface Static : _Static {}

@property (nonatomic, readonly) NSString* name;

@property (nonatomic) Info* info;

+ (instancetype)objectForKey:(NSString*)key inContext:(NSManagedObjectContext*)context;

+ (Class)detailViewControllerClass;

@end
