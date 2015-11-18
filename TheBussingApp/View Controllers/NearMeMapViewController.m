//
//  NearMeMapViewController.m
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 2/23/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "NearMeMapViewController.h"
#import "NearMeTableViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ConnectionManager.h"
#import "DatabaseManager.h"
#import "IncomingBusesViewController.h"
#import "Constants.h"
#import "XMLDictionary.h"
#import "RouteLineMenuViewController.h"
#import "Styleable.h"
#import "NearMeErrorHandler.h"
#import "MBProgressHUD.h"

@interface NearMeMapViewController () <GMSMapViewDelegate, RouteLineChanger, StylesItself>

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) NearMeMapViewController *tableController;
@property(strong, nonatomic) NSMutableArray *markerArray;
@property(strong, nonatomic) NSArray *incomingBuses;
@property(strong, nonatomic) NSString *selectedStopName;
@property(strong, nonatomic) NSDictionary *routeCoordinatesDictionary;
@property(strong, nonatomic) NSArray *routeCoordinatesArray;
@property(strong, nonatomic) GMSMapView *map;
@property(strong, nonatomic) NSMutableArray *polylineArray;
@property(strong, nonatomic) RouteLineMenuViewController *routeLineMenu;
@property(strong, nonatomic) NSMutableArray *polylinesShowing;
@property (weak, nonatomic) IBOutlet UIButton *routeLineButton;
@property(strong, nonatomic) MBProgressHUD *progress;

@property(strong, nonatomic) NSMutableArray *line;
@property(strong, nonatomic) GMSPolyline *poly;

@property(strong, nonatomic) NSString *string;

@end

@implementation NearMeMapViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)styleViews
{
    self.view.tintColor = [Constants getAppTintColor];
    self.view.backgroundColor = [Constants getBackgroundColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.line = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    
    [self styleViews];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.string = @"";
    self.polylineArray = [[NSMutableArray alloc] init];
    self.polylinesShowing = [[NSMutableArray alloc] init];
    
    ConnectionManager *conman = [ConnectionManager new];
    [conman update_gps];
    
//    double myLat = [[conman get_latitude] doubleValue];
//    double myLon = [[conman get_longitude] doubleValue];
    
    // Racine
//    double myLat = 42.782772;
//    double myLon = -87.808052;
    
    // Parkside
    double myLat = 42.6432133;
    double myLon = -87.8479223;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:myLat longitude:myLon zoom:14];
    
    self.map = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.map.center = self.view.center;
    [self.map setMinZoom:0 maxZoom:20];
    
    self.map.myLocationEnabled = YES;
    
    [self.view insertSubview:self.map atIndex:0];
    self.map.delegate = self;
    
    [self presentWaitOverlay];
    [self getNearbyRoutes];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self putRouteLinesOnMap];
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Near Me Map Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)presentWaitOverlay
{
    self.progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progress.labelText = @"Loading routes";
}

- (void)getNearbyRoutes
{
    dispatch_queue_t queue = dispatch_queue_create("Get Routes Queue", NULL);
    dispatch_async(queue, ^{
        DatabaseManager *db;
        db = [DatabaseManager getSharedInstance];
        self.routes = [db getNearbyRoutes];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self dataFinishedLoading];
        });
    });
}

- (void)dataFinishedLoading
{
    [self.progress hide:true];
    [self displayMarkersOnMap];
    
    if(self.routes.count == 0)
    {
        [self displayErrorMessage];
    }
}

- (void)displayErrorMessage
{
    NSString *errorText = [NearMeErrorHandler getErrorMessageForEmptyStopArray];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry!" message:errorText preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okAction];
    alert.view.tintColor = [Constants getBackgroundColor];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)displayMarkersOnMap
{
    for(int i=0; i < self.routes.count; i++)
    {
        NSArray *route = self.routes[i];
        
        GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake([route[1] floatValue]
                                                                                     , [route[2] floatValue])];
        marker.userData = [NSNumber numberWithInt:i];
        marker.snippet = route[0];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = self.map;
        
        marker.icon = [GMSMarker markerImageWithColor:[Constants getRouteColorForRoute:route[8]]];
    }
}

- (void)putRouteLinesOnMap
{
    if(!self.routeCoordinatesDictionary)
    {
        NSString *fileName = [Constants getRouteCoordinatesFileName];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        self.routeCoordinatesDictionary = [NSDictionary dictionaryWithXMLFile:filePath];
    }

    if(!self.routeCoordinatesArray)
    {
        self.routeCoordinatesArray = self.routeCoordinatesDictionary[@"route"];
    }
    for(int k = 0; k < [Constants getListOfRouteNames].count; k++)
    {
        NSArray *routeCoords = self.routeCoordinatesArray[k][@"coord"];
        
        GMSMutablePath *path = [GMSMutablePath path];
        for(int i = 0; i < routeCoords.count; i ++)
        {
            NSDictionary *coord = routeCoords[i];
            [path addCoordinate:CLLocationCoordinate2DMake([coord[@"lat"] doubleValue], [coord[@"lon"] doubleValue])];
        }
        
        GMSPolyline *line = [GMSPolyline polylineWithPath:path];
        NSString *route = [Constants getRoutesFromOrderedIndex:k];
        line.strokeColor = [Constants getRouteColorForRoute:route];
        line.strokeWidth = 7;
        [self.polylineArray addObject:line];
        [self.polylinesShowing addObject:@"No"];
    }
}

- (void)changePolyine
{
    GMSPolyline *line = (GMSPolyline*)self.polylineArray[self.routeLineMenu.index];

    if(self.routeLineMenu.enable)
    {
        line.map = _map;
    } else
    {
        line.map = nil;
    }
    
    self.polylinesShowing[self.routeLineMenu.index] = self.routeLineMenu.enable ? @"Yes": @"No";
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    NSArray *route = self.routes[[marker.userData intValue]];
    
    NSString *lat = [NSString stringWithFormat:@"%f", [route[1] floatValue]];
    NSString *lon = [NSString stringWithFormat:@"%f", [route[2] floatValue]];
    
    NSString *coordinatesXML = @"";
    
    coordinatesXML = [coordinatesXML stringByAppendingString:@"<coord> \n"];
    coordinatesXML = [coordinatesXML stringByAppendingString:[NSString stringWithFormat:@"<lat> %@ </lat> \n", lat]];
    coordinatesXML = [coordinatesXML stringByAppendingString:[NSString stringWithFormat:@"<lon> %@ </lon> \n", lon]];
    coordinatesXML = [coordinatesXML stringByAppendingString:@"</coord> \n"];
    
    self.string = [self.string stringByAppendingString:coordinatesXML];

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
    
    UIAlertAction *routeAction = [UIAlertAction actionWithTitle:@"Directions To" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
             [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps-x-callback://?daddr=%@,%@&directionsmode=walking&x-success=App://?resume=true&x-source=App", route[1], route[2] ]]];
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
    
    alert.view.tintColor = [Constants getBackgroundColor];
    
    [alert addAction:routeAction];
    [alert addAction:busAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return YES;
}

- (IBAction)listButtonPressed:(UIBarButtonItem *)sender
{
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"List"])
    {
        self.tableController = [self.storyboard instantiateViewControllerWithIdentifier:@"NearMeTableView"];
        self.tableController.routes = self.routes;
        
        [self addChildViewController:self.tableController];
        [self.view addSubview:self.tableController.view];
        [self.tableController didMoveToParentViewController:self];
        self.navigationItem.rightBarButtonItem.title = @"Map";
    } else
    {
        self.navigationItem.rightBarButtonItem.title = @"List";
        
        [self.tableController.view removeFromSuperview];
        [self.tableController removeFromParentViewController];
    }
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

- (IBAction)displayRouteMenu:(UIButton *)sender
{
    self.routeLineMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"RouteLineMenu"];
    self.routeLineMenu.delegate = self;
    self.routeLineMenu.polylinesShowing = self.polylinesShowing;
    self.routeLineMenu.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:self.routeLineMenu animated:YES completion:nil];
}

#pragma mark - Route Line Gathering
- (void)setupRouteBuilder
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [button addTarget:self action:@selector(publishLineToXML) forControlEvents:UIControlEventTouchDown];
    button.backgroundColor = [UIColor blackColor];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
    [button2 addTarget:self action:@selector(deleteCoord) forControlEvents:UIControlEventTouchDown];
    button2.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button];
    [self.view addSubview:button2];
}

//- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    NSNumber *lat = [NSNumber numberWithDouble:coordinate.latitude];
//    NSNumber *lon = [NSNumber numberWithDouble:coordinate.longitude];
//
//    NSArray *coord = @[lat, lon];
//
//    [self.line addObject:coord];
//
//    GMSMutablePath *path = [[GMSMutablePath alloc] init];
//
//    for (NSArray *point in self.line)
//    {
//        [path addCoordinate:CLLocationCoordinate2DMake([point[0] doubleValue], [point[1] doubleValue])];
//    }
//
//    self.poly.map = nil;
//    self.poly = nil;
//
//    self.poly = [GMSPolyline polylineWithPath:path];
//    self.poly.strokeWidth = 5;
//    self.poly.map = self.map;
//}

- (void)publishLineToXML
{
    NSString *xml = @"<route>";

    for (NSArray *coord in self.line)
    {
        NSNumber *lat = coord[0];
        NSNumber *lon = coord[1];

        xml = [xml stringByAppendingString:[NSString stringWithFormat:@"\n<coord>\n<lat>%@</lat>\n<lon>%@</lon>\n</coord>", lat, lon]];
    }

    xml = [xml stringByAppendingString:@"\n</route>"];

    NSLog(@"%@", xml);
}

- (void)deleteCoord
{
    [self.line removeLastObject];

    self.poly.map = nil;
    self.poly = nil;

    GMSMutablePath *path = [[GMSMutablePath alloc] init];

    for (NSArray *point in self.line)
    {
        [path addCoordinate:CLLocationCoordinate2DMake([point[0] doubleValue], [point[1] doubleValue])];
    }

    self.poly = [GMSPolyline polylineWithPath:path];
    self.poly.strokeWidth = 5.0;
    self.poly.map = self.map;
}

- (void)displayRouteLineButtons
{
    UIButton *xmlButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    xmlButton.backgroundColor = [UIColor blackColor];
    [xmlButton addTarget:self action:@selector(publishLineToXML) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xmlButton];
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 100, 50, 30)];
    deleteButton.backgroundColor = [UIColor redColor];
    [deleteButton addTarget:self action:@selector(deleteCoord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
}

@end
