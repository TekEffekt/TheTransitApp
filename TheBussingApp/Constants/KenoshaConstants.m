//
//  KenoshaConstants.m
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import "KenoshaConstants.h"

static NSString * const description1 = @"Welcome to the KAT App, the ultimate guide for the Kenosha busing system! Read through this tutorial to learn how to find all the bus stops near you, when buses will be arriving at those stops, and more!";
static NSString * const description2 = @"This button will take you to the Stops Near Me screen, where you can see bus stops that are closest to you.";
static NSString * const description3 = @"This is the Stops Near me screen, where you can see each stop on the map as a red marker. Touch a marker to either get walking directions to that stop or see the buses that will be coming to that stop.";
static NSString *const description4 = @"This button will allow you to see all of the routes on the map as colored lines. You can toggle specific ones on and off.";
static NSString * const description5 = @"Touch this button to see the stops as a list instead of on the map.";
static NSString * const description6 = @"Here you can see all of the stops as a list instead of scattered on a map. You can also see how many miles away that each stop is. Just like the map screen, touch on a stop to get directions or incoming buses for it.";
static NSString * const description7 = @"This is the Incoming Buses Screen, where you can see all of the buses coming to a given stop(displayed at the top in the yellow banner) The route number, arrival time, and time remaining is all displayed.";
static NSString * const description8 = @"Touching this button allows you to scan a QR code that is mounted at a bus stop. After scanning the QR code, the Incoming Buses screen will open showing you the buses that will be coming to that stop.";
static NSString * const description9 = @"This button launches Google Maps transit, which allows you to figure out what buses that you will need to take to get somewhere in Kenosha.";
static NSString * const description10 = @"This is the help button, which will show you this tutorial again if you need it.";
static NSString * const description11 = @"Lastly, if you tap the help button, you go to a screen with a How To Button that will reload this tutorial if you'd like to see it again. Enjoy the app!";

@implementation KenoshaConstants

+ (NSArray*)getListOfRouteNames
{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"31"];
}

+ (NSString*)getGoogleMapsApiKey
{
    return @"AIzaSyCehHwgsEcrwtbWV5Z9wrvacI0NyRhZyrI";
}

+ (NSString*)getGoogleAnalyticsTrackingId
{
    return @"UA-55565400-1";
}

+ (NSString*)getShortHandForRoute:(NSString*)route
{
    return route;
}

+ (NSString*)getRouteCoordinatesFileName
{
    return @"KenoshaRouteCoordinates";
}

+ (NSString*)getTextForIndex:(int)index
{
    NSArray *descriptions = @[description1, description2, description3, description4, description5, description6, description7, description8, description9, description10, description11];
    
    return descriptions[index];
}

+ (UIColor *)getRouteColorForRoute:(NSString*)route
{
    UIColor *routeColor;
    
    int number = [route intValue];
    
    switch (number) {
        case 1:
            //Route 1 is orange
            routeColor = [UIColor colorWithRed:0.969 green:0.576 blue:0.114 alpha:1]; /*#f7931d*/
            break;
        case 2:
            //route 2 is blue
            routeColor = [UIColor colorWithRed:0 green:0.584 blue:0.851 alpha:1]; /*#0095d9*/
            break;
        case 3:
            //route 3 is gray
            routeColor = [UIColor colorWithRed:0.761 green:0.671 blue:0.529 alpha:1]; /*#c2ab87*/
            break;
        case 4:
            //route 4 is green
            routeColor = [UIColor colorWithRed:0 green:0.647 blue:0.314 alpha:1]; /*#00a550*/
            break;
        case 5:
            //route 5 is red
            routeColor = [UIColor colorWithRed:0.843 green:0.086 blue:0.204 alpha:1]; /*#d71634*/
            break;
        case 6:
            //route 6 is purple
            routeColor = [UIColor colorWithRed:0.635 green:0.137 blue:0.557 alpha:1]; /*#a2238e*/
            break;
        case 31:
            //route 31 is navy blue
            routeColor = [UIColor colorWithRed:0 green:0.247 blue:0.439 alpha:1]; /*#003f70*/
            break;
        default:
            //default background is black
            routeColor = [UIColor blackColor];
            NSLog(@"NUMBER : %d", number);
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
    return [UIColor colorWithRed:0.894 green:0.824 blue:0.333 alpha:1];
}

+ (UIColor*)getBackgroundColor
{
    return [UIColor colorWithRed:0.18 green:0.176 blue:0.333 alpha:1];
}

+ (NSArray*)getScheduleBeginEndTimes
{
    return @[@5, @20];
}

+ (NSArray*)getAvailableDays
{
    return @[@"monday",@"tuesday",@"wednesday",@"thursday",@"friday",@"saturday"];
}

@end
