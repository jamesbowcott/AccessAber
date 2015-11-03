#import "Info.h"
#import "Static.h"
@interface Info ()

// Private interface goes here.

@end

@implementation Info {
    NSArray* _viewableProperties;
}

- (NSUInteger)numberOfViewableProperties {
    return self.entity.properties.count - 1;
}

- (NSArray*)viewableProperties {
    if (!_viewableProperties) {
        NSMutableArray* a = [NSMutableArray arrayWithCapacity:self.entity.properties.count];
        [self.entity.propertiesByName enumerateKeysAndObjectsUsingBlock:^(NSString* propertyName, id property, BOOL *stop) {
            if (![propertyName isEqualToString:@"name"] && ![propertyName isEqualToString:self.parent.entity.name] && [self valueForKey:propertyName]) {
                [a addObject:property];
            }
        }];
        _viewableProperties = [NSArray arrayWithArray:a];
    }
    return _viewableProperties;
}


@end
