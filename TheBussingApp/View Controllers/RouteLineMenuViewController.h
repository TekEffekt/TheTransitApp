//
//  RouteLineMenuViewController.h
//  Racine-Transit
//
//  Created by Kyle Zawacki on 6/24/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RouteLineChanger;

@interface RouteLineMenuViewController : UIViewController

@property(assign, nonatomic) id<RouteLineChanger> delegate;
@property(nonatomic) int index;
@property(nonatomic) BOOL enable;
@property(strong, nonatomic) NSMutableArray *polylinesShowing;

@end

@protocol RouteLineChanger <NSObject>

- (void)changePolyine;

@end

