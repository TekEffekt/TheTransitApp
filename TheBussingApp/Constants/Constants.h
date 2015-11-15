//
//  Constants.h
//  
//
//  Created by Kyle Zawacki on 8/4/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

+ (NSString*)getTextForIndex:(int)index;
+ (UIColor*)getRouteColorForRoute:(NSString*)route;
+ (NSString*)getRoutesFromOrderedIndex:(int)index;
+ (UIColor*)getAppTintColor;
+ (UIColor*)getBackgroundColor;
+ (NSString*)getDBName;
+ (NSArray*)getScheduleBeginEndTimes;
+ (NSArray*)getAvailableDays;
+ (NSString*)getRouteCoordinatesFileName;
+ (NSArray*)getListOfRouteNames;
+ (NSString*)getShortHandForRoute:(NSString*)route;

@end
