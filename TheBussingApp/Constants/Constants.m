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
    
    switch (number) {
        case 1:
            routeColor = [UIColor colorWithRed:0.863 green:0.216 blue:0.459 alpha:1]; /*#dc3775*/
            break;
        case 2:
            routeColor = [UIColor colorWithRed:0.612 green:0.475 blue:0.286 alpha:1]; /*#9c7949*/
            break;
        case 3:
            routeColor = [UIColor colorWithRed:1 green:0.843 blue:0.18 alpha:1]; /*#ffd72e*/
            break;
        case 4:
            routeColor = [UIColor colorWithRed:0 green:0.627 blue:0.894 alpha:1]; /*#00a0e4*/
            break;
        case 5:
            routeColor = [UIColor colorWithRed:0.796 green:0.529 blue:0.592 alpha:1]; /*#cb8797*/
            break;
        case 7:
            //route 7 is navy blue
            routeColor = [UIColor colorWithRed:0.51 green:0.494 blue:0.706 alpha:1]; /*#827eb4*/
            break;
        case 20:
            routeColor = [UIColor colorWithRed:0.208 green:0.196 blue:0.616 alpha:1]; /*#35329d*/
            break;
        case 27:
            routeColor = [UIColor colorWithRed:0.208 green:0.388 blue:0.314 alpha:1]; /*#356350*/
            break;
        case 86:
            routeColor = [UIColor colorWithRed:0.835 green:0.565 blue:0.231 alpha:1]; /*#d5903b*/;
            break;
        default:
            //default background is black
            routeColor = [UIColor blackColor];
            break;
    }
    
    return routeColor;
}

+ (int)getRouteNumberInOrder:(int)routeNumber
{
    if(routeNumber == 7)
    {
        routeNumber = 6;
    } else if(routeNumber == 20)
    {
        routeNumber = 7;
    } else if(routeNumber == 27)
    {
        routeNumber = 8;
    } else if(routeNumber == 86)
    {
        routeNumber = 9;
    }
    
    routeNumber--;
    
    return routeNumber;
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
