//
//  Styleable.h
//  TheBussingApp
//
//  Created by Kyle Zawacki on 8/4/15.
//  Copyright (c) 2015 App Factory. All rights reserved.
//
//  A special protocol for the app that specifies that a class will style itself according
//  to its city.

#import <Foundation/Foundation.h>

@protocol StylesItself;

@interface Styleable : NSObject

@end

@protocol StylesItself <NSObject>

- (void)styleViews;

@end

