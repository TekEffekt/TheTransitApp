//
//  RacineConstants.m
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import "RacineConstants.h"

static NSString * const description1 = @"Welcome to the Racine Transit App, the ultimate guide for the Belle Urban system! Read through this tutorial to learn how to find all the bus stops near you, when buses will be arriving at those stops, and more!";
static NSString * const description2 = @"This button will take you to the Stops Near Me screen, where you can see bus stops that are closest to you.";
static NSString * const description3 = @"This is the Stops Near me screen, where you can see each stop on the map as a red marker. Touch a marker to either get walking directions to that stop or see the buses that will be coming to that stop.";
static NSString *const description4 = @"This button will allow you to see all of the routes on the map as colored lines. You can toggle specific ones on and off.";
static NSString * const description5 = @"Touch this button to see the stops as a list instead of on the map.";
static NSString * const description6 = @"Here you can see all of the stops as a list instead of scattered on a map. You can also see how many miles away that each stop is. Just like the map screen, touch on a stop to get directions or incoming buses for it.";
static NSString * const description7 = @"This is the Incoming Buses Screen, where you can see all of the buses coming to a given stop(displayed at the top in the yellow banner) The route number, arrival time, and time remaining is all displayed.";
static NSString * const description8 = @"Touching this button allows you to scan a QR code that is mounted at a bus stop. After scanning the QR code, the Incoming Buses screen will open showing you the buses that will be coming to that stop.";
static NSString * const description9 = @"This button launches Google Maps transit, which allows you to figure out what buses that you will need to take to get somewhere in Racine.";
static NSString * const description10 = @"This is the help button, which will show you this tutorial again if you need it.";
static NSString * const description11 = @"Lastly, if you tap the help button, you go to a screen with a How To Button that will reload this tutorial if you'd like to see it again. Enjoy the app!";

@implementation RacineConstants

+ (NSString*)getTextForIndex:(int)index
{
    NSArray *descriptions = @[description1, description2, description3, description4, description5, description6, description7, description8, description9, description10, description11];
    
    return descriptions[index];
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
    return [UIColor colorWithRed:0.58 green:0.878 blue:0.157 alpha:1];
}

+ (UIColor*)getBackgroundColor
{
    return [UIColor colorWithRed:0.086 green:0.365 blue:0.565 alpha:1];
}


@end
