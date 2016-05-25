//
//  Constants.m
//  
//
//  Created by Kyle Zawacki on 8/4/15.
//
//

#import "Constants.h"
#import "RacineConstants.h"
#import "KenoshaConstants.h"
#import "WesternKenoshaConstants.h"
#import "LacrosseConstants.h"

@implementation Constants

+ (NSArray*)getListOfRouteNames
{
    #ifdef Racine
        return [RacineConstants getListOfRouteNames];
    #elif Kenosha
        return [KenoshaConstants getListOfRouteNames];
    #elif WesternKenosha
        return [WesternKenoshaConstants getListOfRouteNames];
    #elif Lacrosse
        return [LacrosseConstants getListOfRouteNames];
    #endif
}

+ (NSString*)getGoogleMapsApiKey
{
    #ifdef Racine
        return [RacineConstants getGoogleMapsApiKey];
    #elif Kenosha
        return [KenoshaConstants getGoogleMapsApiKey];
    #elif WesternKenosha
        return [WesternKenoshaConstants getGoogleMapsApiKey];
    #elif Lacrosse
        return [LacrosseConstants getGoogleMapsApiKey];
#endif
}

+ (NSString*)getGoogleAnalyticsTrackingId
{
    #ifdef Racine
        return [RacineConstants getGoogleAnalyticsTrackingId];
    #elif Kenosha
        return [KenoshaConstants getGoogleAnalyticsTrackingId];
    #elif WesternKenosha
        return [WesternKenoshaConstants getGoogleAnalyticsTrackingId];
    #elif Lacrosse
        return [LacrosseConstants getGoogleAnalyticsTrackingId];
    #endif
}

+ (NSString*)getShortHandForRoute:(NSString*)route
{
    NSString *shortHand = @"";
    
    #ifdef Racine
        shortHand = [RacineConstants getShortHandForRoute:route];
    #elif Kenosha
        shortHand = [KenoshaConstants getShortHandForRoute:route];
    #elif WesternKenosha
        shortHand = [WesternKenoshaConstants getShortHandForRoute:route];
    #elif Lacrosse
        shortHand = [LacrosseConstants getShortHandForRoute:route];
    #endif
    
    return shortHand;
}

+ (NSString*)getRouteCoordinatesFileName
{
    NSString *fileName = nil;
    
    #ifdef Racine
        fileName = [RacineConstants getRouteCoordinatesFileName];
    #elif Kenosha
        fileName = [KenoshaConstants getRouteCoordinatesFileName];
    #elif WesternKenosha
        fileName = [WesternKenoshaConstants getRouteCoordinatesFileName];
    #elif Lacrosse
        fileName = [LacrosseConstants getRouteCoordinatesFileName];
    #endif
    
    return fileName;
}

+ (NSString*)getTextForIndex:(int)index
{
    NSString *description = nil;
    
    #ifdef Racine
        description = [RacineConstants getTextForIndex:index];
    #elif Kenosha
        description = [KenoshaConstants getTextForIndex:index];
    #elif WesternKenosha
        description = [WesternKenoshaConstants getTextForIndex:index];
    #elif Lacrosse
        description = [LacrosseConstants getTextForIndex:index];
    #endif
    
    return description;
}

+ (UIColor *)getRouteColorForRoute:(NSString*)route
{
    UIColor *routeColor;
    
    #ifdef Racine
        routeColor = [RacineConstants getRouteColorForRoute:route];
    #elif Kenosha
        routeColor = [KenoshaConstants getRouteColorForRoute:route];
    #elif WesternKenosha
        routeColor = [WesternKenoshaConstants getRouteColorForRoute:route];
    #elif Lacrosse
        routeColor = [LacrosseConstants getRouteColorForRoute:route];
    #endif
    
    return routeColor;
}

+ (NSString*)getRoutesFromOrderedIndex:(int)index
{
    NSString *route;
    #ifdef Racine
        route = [RacineConstants getRoutesFromOrderedIndex:index];
    #elif Kenosha
        route =  [KenoshaConstants getRoutesFromOrderedIndex:index];
    #elif WesternKenosha
        route = [WesternKenoshaConstants getRoutesFromOrderedIndex:index];
    #elif Lacrosse
        route = [LacrosseConstants getRoutesFromOrderedIndex:index];
    #endif
    return route;
}

+ (UIColor*)getAppTintColor
{
    #ifdef Racine
        return [RacineConstants getAppTintColor];
    #elif Kenosha
        return [KenoshaConstants getAppTintColor];
    #elif WesternKenosha
        return [WesternKenoshaConstants getAppTintColor];
    #elif Lacrosse
        return [LacrosseConstants getAppTintColor];
    #endif
}

+ (UIColor*)getBackgroundColor
{
    #ifdef Racine
        return [RacineConstants getBackgroundColor];
    #elif Kenosha
        return [KenoshaConstants getBackgroundColor];
    #elif WesternKenosha
        return [WesternKenoshaConstants getBackgroundColor];
    #elif Lacrosse
        return [LacrosseConstants getBackgroundColor];
    #endif
}

+ (NSString*)getDBName
{
    #ifdef Racine
        return @"racineDB";
    #elif Kenosha
        return @"kenoshaDB";
    #elif WesternKenosha
        return @"westernKenoshaDB";
    #elif Lacrosse
        return @"lacrosseDB";
    #endif
}

+ (NSArray*)getScheduleBeginEndTimes
{
    #ifdef Racine
        return [RacineConstants getScheduleBeginEndTimes];
    #elif Kenosha
        return [KenoshaConstants getScheduleBeginEndTimes];
    #elif WesternKenosha
        return [WesternKenoshaConstants getScheduleBeginEndTimes];
    #elif Lacrosse
        return [LacrosseConstants getScheduleBeginEndTimes];
    #endif
}

+ (NSArray*)getAvailableDays
{
    #ifdef Racine
        return [RacineConstants getAvailableDays];
    #elif Kenosha
        return [KenoshaConstants getAvailableDays];
    #elif WesternKenosha
        return [WesternKenoshaConstants getAvailableDays];
    #elif Lacrosse
        return [LacrosseConstants getAvailableDays];
    #endif
}

+ (NSString*)getAboutHtmlFilename {
    #ifdef Racine
        return [RacineConstants getAboutHtmlFilename];
    #elif Kenosha
        return [KenoshaConstants getAboutHtmlFilename];
    #elif WesternKenosha
        return [WesternKenoshaConstants getAboutHtmlFilename];
    #elif Lacrosse
        return [LacrosseConstants getAboutHtmlFilename];
    #endif
}

+ (NSString*)getContactHtmlFilename {
    #ifdef Racine
        return [RacineConstants getContactHtmlFilename];
    #elif Kenosha
        return [KenoshaConstants getContactHtmlFilename];
    #elif WesternKenosha
        return [WesternKenoshaConstants getContactHtmlFilename];
    #elif Lacrosse
        return [LacrosseConstants getContactHtmlFilename];
    #endif
}

@end
