#import "MultilingualString.h"
#import "AppDelegate.h"

@interface MultilingualString ()

// Private interface goes here.

@end

@implementation MultilingualString

- (NSString*)defaultString {
    NSString* s = [self primitiveValueForKey:[self defaultLanguage]];
    if (!s)
        s = self.base;
    if (!s)
        s = self.en;
    if (!s)
        s = @"NO STRING";
    return s;
}

- (NSString*)defaultLanguage {
    return [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
}

- (instancetype)init {
    NSManagedObjectContext* context = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    return ((self = [self initWithEntity:[MultilingualString entityInManagedObjectContext:context] insertIntoManagedObjectContext:context]));
}

+ (instancetype)stringWithDictionary:(NSDictionary*)dictionary {
    return [[MultilingualString alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [self init])) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (BOOL)isKindOfClass:(Class)aClass {
    return (aClass == [NSString class] ||
            [super isKindOfClass:aClass]);
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return ([super respondsToSelector:aSelector] ||
            [[self defaultString] respondsToSelector:aSelector]);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([[self defaultString] respondsToSelector:aSelector])
        return [self defaultString];
    else
        return nil;
}

@end
