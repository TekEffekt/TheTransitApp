//
//  WesternKenoshaConstants.m
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import "WesternKenoshaConstants.h"

static NSString * const description1 = @"Welcome to the Western Kenosha Transit App! Read through this tutorial to learn how to find all the bus stops near you, when buses will be arriving at those stops, and more!";
static NSString * const description2 = @"This button will take you to the Stops Near Me screen, where you can see bus stops that are closest to you.";
static NSString * const description3 = @"This is the Stops Near me screen, where you can see each stop on the map as a red marker. Touch a marker to either get walking directions to that stop or see the buses that will be coming to that stop.";
static NSString *const description4 = @"This button will allow you to see all of the routes on the map as colored lines. You can toggle specific ones on and off.";
static NSString * const description5 = @"Touch this button to see the stops as a list instead of on the map.";
static NSString * const description6 = @"Here you can see all of the stops as a list instead of scattered on a map. You can also see how many miles away that each stop is. Just like the map screen, touch on a stop to get directions or incoming buses for it.";
static NSString * const description7 = @"This is the Incoming Buses Screen, where you can see all of the buses coming to a given stop(displayed at the top in the yellow banner) The route number, arrival time, and time remaining is all displayed.";
static NSString * const description8 = @"Touching this button allows you to scan a QR code that is mounted at a bus stop. After scanning the QR code, the Incoming Buses screen will open showing you the buses that will be coming to that stop.";
static NSString * const description9 = @"This button launches Google Maps transit, which allows you to figure out what buses that you will need to take to get somewhere in West Kenosha.";
static NSString * const description10 = @"This is the help button, which will show you this tutorial again if you need it.";
static NSString * const description11 = @"Lastly, if you tap the help button, you go to a screen with a How To Button that will reload this tutorial if you'd like to see it again. Enjoy the app!";

@implementation WesternKenoshaConstants

+ (NSArray*)getListOfRouteNames
{
    return @[@"Antioch",@"Geneva",@"Kenosha",@"Paddock"];
}

+ (NSString*)getGoogleMapsApiKey
{
    return @"AIzaSyDRXqlP_tjwyWDPF1tFQZvxO8ih3FuqymU";
}

+ (NSString*)getGoogleAnalyticsTrackingId
{
    return @"UA-71025041-1";
}

+ (NSString*)getShortHandForRoute:(NSString*)route
{
    if([route isEqualToString:@"Antioch"])
    {
        return @"Ant";
    } else if([route isEqualToString:@"Geneva"])
    {
        return @"Gen";
    } else if([route isEqualToString:@"Kenosha"])
    {
        return @"Ken";
    } else
    {
        return @"Pad";
    }
}

+ (NSString*)getRouteCoordinatesFileName
{
    return @"westernKenoshaRouteCoordinates";
}

+ (NSString*)getTextForIndex:(int)index
{
    NSArray *descriptions = @[description1, description2, description3, description4, description5, description6, description7, description8, description9, description10, description11];
    
    return descriptions[index];
}

+ (UIColor *)getRouteColorForRoute:(NSString*)route
{
    UIColor *routeColor;
    route = [route capitalizedString];
    
    if([route isEqualToString:@"Antioch"])
    {
        routeColor = [UIColor colorWithRed:0.00 green:0.38 blue:0.20 alpha:1.0];
    } else if([route isEqualToString:@"Geneva"])
    {
        routeColor = [UIColor colorWithRed:0.54 green:0.37 blue:0.52 alpha:1.0];
    } else if([route isEqualToString:@"Kenosha"])
    {
        routeColor = [UIColor colorWithRed:0.00 green:0.36 blue:0.55 alpha:1.0];
    } else
    {
        routeColor = [UIColor colorWithRed:0.90 green:0.49 blue:0.22 alpha:1.0];
    }
    
    return routeColor;
}

+ (NSString*)getRoutesFromOrderedIndex:(int)index
{
    return [self getListOfRouteNames][index];
}

+ (UIColor*)getAppTintColor
{
    return [UIColor colorWithRed:0.894 green:0.824 blue:0.333 alpha:1];
}

+ (UIColor*)getBackgroundColor
{
    return [UIColor colorWithRed:0.102 green:0.243 blue:0.431 alpha:1];
}

+ (NSArray*)getScheduleBeginEndTimes
{
    return @[@5, @20];
}

+ (NSArray*)getAvailableDays
{
    return @[@"monday",@"tuesday",@"wednesday",@"thursday",@"friday"];
}

+ (NSString*)getAboutHtmlFilename {
    return @"Western Kenosha About";
}

+ (NSString*)getContactHtmlFilename {
    return @"Western Kenosha Contact";
}

@end
