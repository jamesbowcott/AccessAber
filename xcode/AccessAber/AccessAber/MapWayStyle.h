//
//  MapOverlayRenderer.h
//  AccessAber
//
//  Created by James on 27/04/2015.
//  Copyright (c) 2015 Department of Computer Science, Aberystwyth University. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "OSMWay.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]

@interface MapWayStyle : MKOverlayRenderer
+ (NSDictionary*)styles;
+ (BOOL)style:(NSDictionary*)style matchesWay:(OSMWay*)way;
+ (BOOL)setStyleForRenderer:(MKOverlayPathRenderer*)renderer forWay:(OSMWay*)way;
+ (NSInteger)zIndexForWay:(OSMWay*)way;
@end
