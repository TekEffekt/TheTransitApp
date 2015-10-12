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
+ (UIColor*)getRouteColorForRouteNumber:(int)number;
+ (int)getRouteNumberFromArrayIndex:(int)index;
+ (UIColor*)getAppTintColor;
+ (UIColor*)getBackgroundColor;
+ (NSString*)getDBName;
+ (NSArray*)getScheduleBeginEndTimes;
+ (NSArray*)getAvailableDays;
+ (NSString*)getRouteCoordinatesFileName;
+ (NSArray*)getListOfRouteNumbers;

@end
