//
//  NearMeErrorHandler.m
//  TheBussingApp
//
//  Created by Kyle Zawacki on 9/29/15.
//  Copyright © 2015 App Factory. All rights reserved.
//

#import "NearMeErrorHandler.h"
#import "Constants.h"

@implementation NearMeErrorHandler

+ (NSString*)getErrorMessageForEmptyStopArray;
{
    NSString *errorMessage = @"";
    
    int startTime = [[Constants getScheduleBeginEndTimes][0] intValue];
    int endTime = [[Constants getScheduleBeginEndTimes][1] intValue];
    NSString *weekday = [self getToday];
    NSArray *availableDays = [Constants getAvailableDays];
    int currentTime = [[self getCurrentTime] intValue];
    
    if([availableDays containsObject:weekday])
    {
        if(currentTime > startTime && currentTime < endTime)
        {
            errorMessage = [NSString stringWithFormat:@"There are no bus stops near your current location. Hit the Show Route Lines button on the bottom right to see where bus stops are for each route."];
        } else
        {
            errorMessage = [NSString stringWithFormat:@"No buses are available at this time. They run from %dAM to %dPM.", startTime, endTime-12];
        }
    } else
    {
        errorMessage = [NSString stringWithFormat:@"The bus is not available on %@", weekday];
    }
        
    return errorMessage;
}

+ (NSString*)getToday
{
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"cccc"];
    NSString *weekday = [[dateFormatter stringFromDate:now] lowercaseString];

    return weekday;
}

+ (NSString*)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    return currentTimeString;
}

@end
