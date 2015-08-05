//
//  AppDelegate.h
//  KenoshaAreaTransit
//
//  AppDelegate is the first file in the  app to be called from main.  This
//  file is necessary for the app to run.  The delegate is designed to allow
//  extra initialization or cleanup of the app when the app changes state.
//
//  Currently the  App does not require any additional formatting, so this file
//  has been left as it was generated.
//
//  Created by Richard Arthur Lebbin III on 2/6/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"
#import "UpdateManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
