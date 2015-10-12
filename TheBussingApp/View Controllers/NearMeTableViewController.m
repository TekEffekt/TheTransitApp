//
//  NearMeTableViewController.m
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 2/15/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "NearMeTableViewController.h"
#import "BusListTableCell.h"
#import "WYPopoverController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ConnectionManager.h"
#import "IncomingBusesViewController.h"
#import "ConnectionManager.h"
#import "Constants.h"
#import "Styleable.h"

@interface NearMeTableViewController () <WYPopoverControllerDelegate, StylesItself>

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property(strong, nonatomic) UIViewController *mapViewController;
@property(strong, nonatomic) WYPopoverController *popover;
@property(strong, nonatomic) NSString *selectedStopName;

@property(strong, nonatomic) NSArray *incomingBuses;

@end

@implementation NearMeTableViewController

#pragma mark - VC Lifecycle Methods

- (void)styleViews
{
    self.view.tintColor = [Constants getAppTintColor];
    self.view.backgroundColor = [Constants getBackgroundColor];
    self.routesTableView.backgroundColor = [Constants getBackgroundColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.routesTableView.delegate = self;
    self.routesTableView.dataSource = self;
    self.routesTableView.rowHeight = 80;
    
    NSLog(@"%@", self.routes);
    
    [self styleViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Near Me Table Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.routes count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCellId";
    
    BusListTableCell *tableCell = [self.routesTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //assign all table cell information
    NSArray *route = self.routes[indexPath.row];
    
    ConnectionManager *conman = [ConnectionManager new];
    
    [conman update_gps];
    
    double myLat = [[conman get_latitude] doubleValue];
    double myLon = [[conman get_longitude] doubleValue];
    
    CLLocation *currentLoc= [[CLLocation alloc] initWithLatitude:myLat longitude:myLon];
    CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:[route[1] doubleValue] longitude:[route[2] doubleValue]];
    CLLocationDistance meters = [currentLoc distanceFromLocation:stopLoc];
    int milesAway = (int)((meters/1000) * .62137f);
    
    tableCell.dir.text = [NSString stringWithFormat:@"%@", route[0]];
    tableCell.milesLabel.text = [NSString stringWithFormat:@"Miles Away: %d", milesAway];
    
    tableCell.routeLabel.text = [NSString stringWithFormat:@"Route #%d", [route[8] intValue]];
    tableCell.routeNumber = [route[8] intValue];
    tableCell.userInteractionEnabled = YES;

    return tableCell;
}

// Display map popups based on which cell is clicked, showing the user where that bus stop is.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *route = self.routes[indexPath.row];
    
    NSString *stopId = route[4];
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"cccc"];
    NSString *weekday = [[dateFormatter stringFromDate:now] lowercaseString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    
    self.selectedStopName = route[0];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", self.selectedStopName] message:@"Would you like directions to this stop or incoming buses for it?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *busAction = [UIAlertAction actionWithTitle:@"Buses" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dispatch_queue_t queue = dispatch_queue_create("Get Incoming Buses", NULL);
        dispatch_async(queue, ^{
            DatabaseManager *db;
            db = [DatabaseManager getSharedInstance];
            self.incomingBuses = [db getIncomingBusesForStop:stopId AtTime:currentTimeString AndDay:weekday];
            NSLog(@"INCOMING BUSES *****************************************************: %@", self.incomingBuses);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"OpenIncomingBuses" sender:self];
            });
        });
        
    }];
    
    UIAlertAction *routeAction = [UIAlertAction actionWithTitle:@"Directions" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps-x-callback://?daddr=%@,%@&directionsmode=walking&x-success=App://?resume=true&x-source=App", route[1], route[2] ]]];
        } else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Uh oh!" message:@"You need to install the Google Maps app to use this feature!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            
            UIAlertAction *openStoreAction = [UIAlertAction actionWithTitle:@"Open Store" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *iTunesLink = @"https://itunes.apple.com/us/app/google-maps/id585027354?mt=8";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
            }];
            
            [alert addAction:okAction];
            [alert addAction:openStoreAction];
            
            alert.view.tintColor = [UIColor blueColor];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    alert.view.tintColor = [UIColor blueColor];
    
    [alert addAction:routeAction];
    [alert addAction:busAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OpenIncomingBuses"])
    {
        IncomingBusesViewController *controller = segue.destinationViewController;
        controller.incomingBuses = self.incomingBuses;
        controller.stopName = self.selectedStopName;
    }
}

@end
