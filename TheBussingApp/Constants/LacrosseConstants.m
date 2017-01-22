//
//  LacrosseConstants.m
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import "LacrosseConstants.h"

static NSString * const description1 = @"Welcome to the Lacrosse Transit App, the ultimate guide for the Municipal Transit system! Read through this tutorial to learn how to find all the bus stops near you, when buses will be arriving at those stops, and more!";
static NSString * const description2 = @"This button will take you to the Stops Near Me screen, where you can see bus stops that are closest to you.";
static NSString * const description3 = @"This is the Stops Near me screen, where you can see each stop on the map as a red marker. Touch a marker to either get walking directions to that stop or see the buses that will be coming to that stop.";
static NSString *const description4 = @"This button will allow you to see all of the routes on the map as colored lines. You can toggle specific ones on and off.";
static NSString * const description5 = @"Touch this button to see the stops as a list instead of on the map.";
static NSString * const description6 = @"Here you can see all of the stops as a list instead of scattered on a map. You can also see how many miles away that each stop is. Just like the map screen, touch on a stop to get directions or incoming buses for it.";
static NSString * const description7 = @"This is the Incoming Buses Screen, where you can see all of the buses coming to a given stop(displayed at the top in the yellow banner) The route number, arrival time, and time remaining is all displayed.";
static NSString * const description8 = @"Touching this button allows you to scan a QR code that is mounted at a bus stop. After scanning the QR code, the Incoming Buses screen will open showing you the buses that will be coming to that stop.";
static NSString * const description9 = @"This button launches Google Maps transit, which allows you to figure out what buses that you will need to take to get somewhere in Lacrosse.";
static NSString * const description10 = @"This is the help button, which will show you this tutorial again if you need it.";
static NSString * const description11 = @"Lastly, if you tap the help button, you go to a screen with a How To Button that will reload this tutorial if you'd like to see it again. Enjoy the app!";

@implementation LacrosseConstants

+ (NSArray*)getListOfRouteNames
{
    return @[@"1",@"2",@"4",@"5",@"6",@"7",@"8",@"9", @"10", @"GO"];
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
    return route;
}

+ (NSString*)getRouteCoordinatesFileName
{
    return @"LacrosseRouteCoordinates";
}

+ (NSString*)getTextForIndex:(int)index
{
    NSArray *descriptions = @[description1, description2, description3, description4, description5, description6, description7, description8, description9, description10, description11];
    
    return descriptions[index];
}

+ (UIColor *)getRouteColorForRoute:(NSString*)route
{
    UIColor *routeColor;
    
    route = [route stringByReplacingOccurrencesOfString:@"Color" withString:@""];
    route = [route stringByReplacingOccurrencesOfString:@"Route" withString:@""];
    
    int number;
    if( [route isEqualToString:@"GO"]) {
        number = 11;
    } else {
        number = [route intValue];
    }
    
    switch (number) {
        case 1:
            routeColor = [UIColor colorWithRed:0 green:0.329 blue:0.651 alpha:1.0]; /*#0054a6*/
            break;
        case 2:
            routeColor = [UIColor colorWithRed:0.906 green:0.431 blue:0.141 alpha:1.0]; /*#e76e24*/
            break;
        case 4:
            routeColor = [UIColor colorWithRed:0.369 green:0.553 blue:0.243 alpha:1.0]; /*#5e8d3e*/
            break;
        case 5:
            routeColor = [UIColor colorWithRed:0 green:0.396 blue:0.18 alpha:1.0]; /*#00652e*/
            break;
        case 6:
            routeColor = [UIColor colorWithRed:0.184 green:0.18 blue:0.471 alpha:1.0]; /*#2f2e78*/
            break;
        case 7:
            routeColor = [UIColor colorWithRed:0.455 green:0.298 blue:0.22 alpha:1.0]; /*#744c38*/
            break;
        case 8:
            routeColor = [UIColor colorWithRed:0.024 green:0.412 blue:0.463 alpha:1.0]; /*#066976*/
            break;
        case 9:
            routeColor = [UIColor colorWithRed:0.502 green:0.161 blue:0.561 alpha:1.0]; /*#80298f*/
            break;
        case 10:
            routeColor = [UIColor colorWithRed:0.929 green:0.11 blue:0.141 alpha:1.0]; /*#ed1c24*/;
            break;
        case 11:
            routeColor =  [UIColor colorWithRed:0.4 green:0.52 blue:0.96 alpha:1.0]; /*#6685f5*/
            break;
        default:
            //default background is black
            routeColor = [UIColor blackColor];
            break;
    }
    
    return routeColor;
}

+ (NSString*)getRoutesFromOrderedIndex:(int)index
{
    return [self getListOfRouteNames][index];
}

+ (UIColor*)getAppTintColor
{
    return [UIColor colorWithRed:0.918 green:0.698 blue:0.408 alpha:1.0];
}

+ (UIColor*)getBackgroundColor
{
    return [UIColor colorWithRed:0.22 green:0.4 blue:0.482 alpha:1.0];
}

+ (NSArray*)getScheduleBeginEndTimes
{
    return @[@5, @23];
}

+ (NSArray*)getAvailableDays
{
    return @[@"sunday",@"monday",@"tuesday",@"wednesday",@"thursday",@"friday",@"saturday"];
}

+ (NSString*)getAboutHtmlFilename {
    return @"Lacrosse About";
}

+ (NSString*)getContactHtmlFilename {
    return @"Lacrosse Contact";
}

@end
