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

@implementation Constants

+ (NSArray*)getListOfRouteNumbers
{
    #ifdef Racine
        return [RacineConstants getListOfRouteNumbers];
    #elif Kenosha
        return [KenoshaConstants getListOfRouteNumbers];
    #endif
}

+ (NSString*)getRouteCoordinatesFileName
{
    NSString *fileName = nil;
    
    #ifdef Racine
        fileName = [RacineConstants getRouteCoordinatesFileName];
    #elif Kenosha
        fileName = [KenoshaConstants getRouteCoordinatesFileName];
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
    #endif
    
    return description;
}

+ (UIColor *)getRouteColorForRouteNumber:(int)number
{
    UIColor *routeColor;
    
#ifdef Racine
    routeColor = [RacineConstants getRouteColorForRouteNumber:number];
#elif Kenosha
    routeColor = [KenoshaConstants getRouteColorForRouteNumber:number];
#endif
    
    return routeColor;
}

+ (int)getRouteNumberFromArrayIndex:(int)index
{
    #ifdef Racine
        return [RacineConstants getRouteNumberFromArrayIndex:index];
    #elif Kenosha
        return [KenoshaConstants getRouteNumberFromArrayIndex:index];
    #endif
}

+ (UIColor*)getAppTintColor
{
    #ifdef Racine
        return [RacineConstants getAppTintColor];
    #elif Kenosha
        return [KenoshaConstants getAppTintColor];
    #endif
}

+ (UIColor*)getBackgroundColor
{
    #ifdef Racine
        return [RacineConstants getBackgroundColor];
    #elif Kenosha
        return [KenoshaConstants getBackgroundColor];
    #endif
}

+ (NSString*)getDBName
{
    #ifdef Racine
        return @"racineDB";
    #elif Kenosha
        return @"kenoshaDB";
    #endif
}

+ (NSArray*)getScheduleBeginEndTimes
{
    #ifdef Racine
    return [RacineConstants getScheduleBeginEndTimes];
    #elif Kenosha
    return [KenoshaConstants getScheduleBeginEndTimes];
    #endif
}

+ (NSArray*)getAvailableDays
{
#ifdef Racine
    return [RacineConstants getAvailableDays];
#elif Kenosha
    return [KenoshaConstants getAvailableDays];
#endif
}


@end
