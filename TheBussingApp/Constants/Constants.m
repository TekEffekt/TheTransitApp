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

@implementation Constants

+ (NSArray*)getListOfRouteNames
{
    #ifdef Racine
        return [RacineConstants getListOfRouteNames];
    #elif Kenosha
        return [KenoshaConstants getListOfRouteNames];
    #elif WesternKenosha
        return [WesternKenoshaConstants getListOfRouteNames];
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
    #endif
}


@end
