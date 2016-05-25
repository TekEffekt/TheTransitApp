//
//  RacineConstants.h
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WesternKenoshaConstants : NSObject

+ (NSString*)getTextForIndex:(int)index;
+ (UIColor*)getRouteColorForRoute:(NSString*)route;
+ (NSString*)getRoutesFromOrderedIndex:(int)index;
+ (UIColor*)getAppTintColor;
+ (UIColor*)getBackgroundColor;
+ (NSArray*)getScheduleBeginEndTimes;
+ (NSArray*)getAvailableDays;
+ (NSString*)getRouteCoordinatesFileName;
+ (NSArray*)getListOfRouteNames;
+ (NSString*)getShortHandForRoute:(NSString*)route;
+ (NSString*)getGoogleMapsApiKey;
+ (NSString*)getGoogleAnalyticsTrackingId;
+ (NSString*)getAboutHtmlFilename;
+ (NSString*)getContactHtmlFilename;

@end
