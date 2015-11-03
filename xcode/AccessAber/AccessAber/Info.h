#import "_Info.h"

@class Static;

@interface Info : _Info {}


@property (readonly) NSUInteger numberOfViewableProperties;
@property (readonly) NSArray* viewableProperties;
@property (readonly) Static* parent;

- (NSString*)nameForPropertyNamed:(NSString*)propertyName;

@end
