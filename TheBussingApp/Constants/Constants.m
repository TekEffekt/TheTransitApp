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

+ (int)getRouteNumberInOrder:(int)routeNumber
{
    #ifdef Racine
        return [RacineConstants getRouteNumberInOrder:routeNumber];
    #elif Kenosha
        return [KenoshaConstants getRouteNumberInOrder:routeNumber];
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

@end
