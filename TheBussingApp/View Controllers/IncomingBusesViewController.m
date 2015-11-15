//
//  IncomingBusesViewController.m
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 3/28/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "IncomingBusesViewController.h"
#import "IncomingBusCell.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "Constants.h"
#import "Styleable.h"

@interface IncomingBusesViewController () <StylesItself>

@end

@implementation IncomingBusesViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)styleViews
{
    self.tableView.backgroundColor = [Constants getBackgroundColor];
    self.view.backgroundColor = [Constants getBackgroundColor];
    self.view.tintColor = [Constants getAppTintColor];
    self.stopBanner.backgroundColor = [Constants getAppTintColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleViews];
    
    self.navigationController.navigationBarHidden = NO;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"IncomingBusesScreen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateArrivalTime) userInfo:nil repeats:YES];
    
    if(self.incomingBuses.count == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"There are no buses coming for a little while. Come back later!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okAction];
        
        alert.view.tintColor = [Constants getBackgroundColor];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.stopBanner.text = [NSString stringWithFormat:@"At Stop: %@", self.stopName];
    self.navigationController.navigationBarHidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.incomingBuses count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"BusCell";
    
    IncomingBusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *bus = self.incomingBuses[indexPath.row];
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [formatter2 dateFromString:bus[3]];
    
    int arrivalHour = [[bus[3] substringToIndex:2] integerValue];
    int arrivalMin = [[bus[3] substringWithRange:NSMakeRange(3, 2)] integerValue];
    int arrivalSec = [[bus[3] substringWithRange:NSMakeRange(6, 2)] integerValue];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *currComp = [calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:now];
    
    NSInteger currentHour = [currComp hour];
    NSInteger currentMin = [currComp minute];
    NSInteger currentSec = [currComp second];
    
//    currentMin = 60*currentHour + currentMin;
    
    //NSInteger minutesRemaining = ((60*arrivalHour) + arrivalMin) - currentMin;
    int hoursRemaining = abs(currentHour - arrivalHour);
    hoursRemaining--;
    if(hoursRemaining < 0)
    {
        hoursRemaining = 0;
    }
    
    
    int minutesRemaining = arrivalMin - currentMin;
    int secondsRemaining = arrivalSec - currentSec;
    
    if(minutesRemaining < 0)
    {
        minutesRemaining = 60 + minutesRemaining;
    }
    
    if(secondsRemaining < 0)
    {
        secondsRemaining = 60 + secondsRemaining;
    }
    
    cell.route = bus[6];
    cell.routeLabel.text = [[[NSString stringWithFormat:@"Route %@", bus[6]] lowercaseString] capitalizedString];
    cell.timeRemainingLabel.text = [NSString stringWithFormat:@"Time Remaining: %d:%d:%d", hoursRemaining, minutesRemaining, secondsRemaining];
    cell.arrivalLabel.text = [NSString stringWithFormat:@"Arrival Time: %@", [formatter stringFromDate:date]];
    
    return cell;
}

- (void)updateArrivalTime
{
    [self.tableView reloadData];
}

@end
