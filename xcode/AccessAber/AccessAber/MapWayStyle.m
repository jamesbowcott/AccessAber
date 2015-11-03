#import "MapWayStyle.h"

NSArray* _styles;

@implementation MapWayStyle

+ (NSArray*)styles {
    if (!_styles) {
        //_styles = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"OSMRenderStyle2" withExtension:@"plist"]];
        _styles = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"OSMRenderStyle2" withExtension:@"plist"]];
    }
    return _styles;
}

//+ (BOOL)setStyleForRenderer:(MKOverlayPathRenderer*)renderer forWay:(OSMWay*)way {
//    __block BOOL matchedStyle = NO;
//    [MapOverlayRenderer.styles enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* values, BOOL *stop) {
//        if (way.tags[key]) {
//            [values enumerateKeysAndObjectsUsingBlock:^(NSString* value, NSDictionary* style, BOOL *stop) {
//                if (value.length == 0 || [way.tags[key] isEqualToString:value]) {
//                    matchedStyle = YES;
//                    for (NSString* option in style) {
//                        if ([option isEqualToString:@"fillColour"]) {
//                            renderer.fillColor = UIColorFromRGBA([(NSNumber*)style[option] intValue]);
//                        } else if ([option isEqualToString:@"strokeColour"]) {
//                            renderer.strokeColor = UIColorFromRGBA([(NSNumber*)style[option] intValue]);
//                        } else if ([option isEqualToString:@"lineWidth"]) {
//                            renderer.lineWidth = [(NSNumber*)style[option] floatValue];
//                        }
//                    }
//                }
//            }];
//        }
//    }];
//    return matchedStyle;
//}

+ (BOOL)style:(NSDictionary*)style matchesWay:(OSMWay*)way {
    __block BOOL matchedStyle;
    [style[@"tags"] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        *stop = !(matchedStyle = (way.tags[key] && (value.length == 0 || [way.tags[key] isEqualToString:value])));
    }];
    return matchedStyle;
}

+ (BOOL)setStyleForRenderer:(MKOverlayPathRenderer*)renderer forWay:(OSMWay*)way {
    __block BOOL matchedAnyStyle = NO;
    
    for (NSDictionary *style in [MapWayStyle styles]) {
        if ([MapWayStyle style:style matchesWay:way]) {
            matchedAnyStyle = YES;
            for (NSString* option in style) {
                if ([option isEqualToString:@"tags"]) continue;
                else if ([option isEqualToString:@"fillColour"]) {
                    renderer.fillColor = UIColorFromRGBA([(NSNumber*)style[option] intValue]);
                } else if ([option isEqualToString:@"strokeColour"]) {
                    renderer.strokeColor = UIColorFromRGBA([(NSNumber*)style[option] intValue]);
                } else if ([option isEqualToString:@"lineWidth"]) {
                    renderer.lineWidth = [(NSNumber*)style[option] floatValue];
                }
            }
        }
    }
    
    return matchedAnyStyle;
}

+ (NSInteger)zIndexForWay:(OSMWay*)way {
    NSInteger zIndex = 0;
    
    for (NSDictionary *style in [MapWayStyle styles]) {
        if ([MapWayStyle style:style matchesWay:way]) {
            if (style[@"z"])
                zIndex = [style[@"z"] integerValue];
        }
    }
    
    return zIndex;
}

@end
