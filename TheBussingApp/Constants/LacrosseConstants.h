//
//  LacrosseConstants.h
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LacrosseConstants : NSObject

+ (NSString*)getTextForIndex:(int)index;
+ (NSString*)getRoutesFromOrderedIndex:(int)index;
+ (UIColor*)getAppTintColor;
+ (UIColor*)getBackgroundColor;
+ (NSArray*)getScheduleBeginEndTimes;
+ (NSArray*)getAvailableDays;
+ (NSString*)getRouteCoordinatesFileName;
+ (NSArray*)getListOfRouteNames;
+ (UIColor *)getRouteColorForRoute:(NSString*)route;
+ (NSString*)getShortHandForRoute:(NSString*)route;
+ (NSString*)getGoogleMapsApiKey;
+ (NSString*)getGoogleAnalyticsTrackingId;

@end
