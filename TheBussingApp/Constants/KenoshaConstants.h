//
//  KenoshaConstants.h
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KenoshaConstants : NSObject

+ (NSString*)getTextForIndex:(int)index;
+ (UIColor*)getRouteColorForRouteNumber:(int)number;
+ (int)getRouteNumberInOrder:(int)routeNumber;
+ (UIColor*)getAppTintColor;
+ (UIColor*)getBackgroundColor;

@end
