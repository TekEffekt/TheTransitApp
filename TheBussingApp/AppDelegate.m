//
//  AppDelegate.m
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

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GAI.h"
//#import <Pushbots/Pushbots.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    //    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-64356940-1"];
    
    // The Google Maps API Key
    [GMSServices provideAPIKey:@"AIzaSyC_5GHcShRWjTadni0vDLjU9DvMkwLsdYY"];
    
    HomeViewController *home = [HomeViewController alloc];
    home.btnScan.enabled = NO;
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        //App launched, prepare the database
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate date];
        localNotification.alertBody = @"Began checking for latest routes";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        
        DatabaseManager *db;
        db = [DatabaseManager getSharedInstance];
        UpdateManager *updateManager = [[UpdateManager alloc] init];
        [updateManager updateDatabase:[db get_database]];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate date];
            localNotification.alertBody = @"Route updating complete.";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
        });
    });
    
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    self.window.tintColor = [UIColor colorWithRed:0.58 green:0.878 blue:0.157 alpha:1]; /*#94e028*/
    
//    [Pushbots sharedInstanceWithAppId:@"558de155177959c4438b456e"];
//    //Handle notification when the user click it, while app is closed.
//    //This method will show an alert to the user.
//    [[Pushbots sharedInstance] receivedPush:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // This method will be called everytime you open the app
    // Register the deviceToken on Pushbots
//    [[Pushbots sharedInstance] registerOnPushbots:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Notification Registration Error %@", [error userInfo]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //Handle notification when the user click it while app is running in background or foreground.
//    [[Pushbots sharedInstance] receivedPush:userInfo];
    NSLog(@"Recieved remoted");
}

-(void) receivedPush:(NSDictionary *)userInfo {
    NSLog(@"Recieveed");
    //Try to get Notification from [didReceiveRemoteNotification] dictionary
    NSDictionary *pushNotification = [userInfo objectForKey:@"aps"];
    
    if(!pushNotification) {
        //Try as launchOptions dictionary
        userInfo = [userInfo objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        pushNotification = [userInfo objectForKey:@"aps"];
    }
    
    if (!pushNotification)
        return;
    
    //Get notification payload data [Custom fields]
    
    //For example: get viewControllerIdentifer for deep linking
    NSString* notificationViewControllerIdentifer = [userInfo objectForKey:@"notification_identifier"];
    
    //Set the default viewController Identifer
    if(!notificationViewControllerIdentifer)
        notificationViewControllerIdentifer = @"home";
    
    UIAlertView *message =
    [[UIAlertView alloc] initWithTitle:@"Notification"
                               message:[pushNotification valueForKey:@"alert"]
                              delegate:self
                     cancelButtonTitle:nil
                     otherButtonTitles: @"OK",
     nil];
    
    [message show];
    return;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
//        [[Pushbots sharedInstance] OpenedNotification];
    }
}

@end
