//
//  BusRouteListViewController.h
//  KenoshaAreaTransit
//
//  BusRouteListViewController controlls the results list from the scan button
//  of the  App.  The list will display a series of table cells that show the
//  direction, the number, and the time of the route(s) that will go to that stop.
//
//  Created by Valerie Berglind on 2/22/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import "BusRouteListViewController.h"

static int pageNumber = 0;
//POSSIBLE REMOVE
static NSString *dir;
static NSString *selected_route;

//NEW CODE
static NSString *stop_id;
static NSString *route_id;
static NSString *service_id;
static NSString *trip_id;
static NSString *sequence_id;

//END NEW CODE
Boolean isSunday = FALSE;
NSDateFormatter *databaseDateFormatter1;
NSDateFormatter *databaseDateFormatter2;
NSDateFormatter *prettyDateFormatter;
NSDictionary * itemDict;
NSCalendar *calendar;
NSDateComponents *currComp;

@implementation BusRouteListViewController
//@synthesize qrResult,results;
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        id tracker = [[GAI sharedInstance] defaultTracker];
//        
//        // This screen name value will remain set on the tracker and sent with
//        // hits until it is set to a new value or to nil.
//        [tracker set:kGAIScreenName
//               value:@"Bus Route List "];
//        
//        // New SDK versions
//        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//        calendar = [NSCalendar currentCalendar];
//    }
//    return self;
//}
//
//-(id) initWithValue:(NSString *)result{
//    self = [super init];
//    qrResult = result;
//    pageNumber = 0;
//    return self;
//}
//
//-(void) loadView{
//    [super loadView];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    id tracker = [[GAI sharedInstance] defaultTracker];
//    
//    // This screen name value will remain set on the tracker and sent with
//    // hits until it is set to a new value or to nil.
//    [tracker set:kGAIScreenName
//           value:@"Bus Route Screen"];
//    
//    // manual screen tracking
//    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    db = [DatabaseManager getSharedInstance];
//    self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//    // Do any additional setup after loading the view.
//    self.tableView= [[UITableView alloc] initWithFrame:self.view.bounds];
//    self.busListTableView.delegate = self;
//    self.busListTableView.dataSource = self;
//        
//    NSDate *now = [[NSDate alloc] init];
//    NSString *route_title = [DatabaseManager validateValue:qrResult];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"cccc"];
//    NSString *day = [dateFormatter stringFromDate:now];
//    [dateFormatter setDateFormat:@"hh:mm a"];
//    NSString *time = [dateFormatter stringFromDate:now];
//    
//    [dateFormatter setDateFormat:@"HHmm"];
//    NSDate *customizeTime = [NSDate date];
//    time =[dateFormatter stringFromDate:customizeTime];
//    
//    self.busListArray = [[NSMutableArray alloc] init];
//    
//    if (strcmp([day UTF8String], "Saturday") == 0) {
//        day = @"Weekend";
//        isSunday = FALSE;
//    }
//    else if(strcmp([day UTF8String], "Sunday") == 0){
//        isSunday = TRUE;
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"sundayMessage", @"routeDirection", nil];
//        [self.busListArray addObject:dict];
//    }
//    else{
//        day=@"Weekday";
//        isSunday = FALSE;
//    }
//    
//    
//    //check if we are on the first page of the result list
//    if (pageNumber < 1) {
//        results = [db getTimeAndRoute:qrResult time:time day:day];
//
//        //create navigation back button
////        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
////                                                                       style:UIBarButtonItemStyleBordered
////                                                                      target:self
////                                                                      action:@selector(goHome)];
////        self.navigationItem.hidesBackButton = YES;
////        self.navigationItem.leftBarButtonItem = backButton;
////        self.navigationItem.title = route_title;
//    }
//    //check if we are in the next page of the result screen (List all times for the selected direction)
//    if (pageNumber > 0) {
//        results = [db getTimeAndRoute2:qrResult
//                                  route_id:route_id
//                                   sequence_id:sequence_id];
//
//        //create Navigation back button
////        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
////                                                                      target:self
////                                                                      action:@selector(firstQuery)];
////        self.navigationItem.hidesBackButton = YES;
////        self.navigationItem.leftBarButtonItem = backButton;
////        
////        self.navigationItem.title = [NSString stringWithFormat:@"Route %@ from %@", route_id, route_title];
//    }
//    
//    if (results == nil && !isSunday) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid QR Code"
//                                                       message: @"The QR Code you have scanned does not appear to be in our database. Please double check you have scanned a QR Code provided by Kenosha Area Transportation."
//                                                      delegate: self
//                                             cancelButtonTitle:@"Cancel"
//                                             otherButtonTitles:nil];
//        [alert show];
//    }
////    } else if(!isSunday){
//        for ( int i = 0; i < [results count]; i += 10) {
//            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[results objectAtIndex:i], @"stop_name",[results objectAtIndex:(i+1)], @"stop_sequence", [results objectAtIndex:(i+2)], @"stop_id", [results objectAtIndex:(i+3)], @"arrival_time", [results objectAtIndex:(i+4)], @"departure_time", [results objectAtIndex:(i+5)], @"trip_id", [results objectAtIndex:(i+6)], @"route_id", [results objectAtIndex:(i+7)], @"route_color", [results objectAtIndex:(i+8)], @"route_text_color",[results objectAtIndex:(i+9)], @"service_id", nil];
//            
//            //if routeTime == 9999  then it is not a valid route
////            if(![[dict objectForKey:@"routeTime"]  isEqual: @"9999"]){
////                //add route
//                [self.busListArray addObject:dict];
////            }
//        }
//        //display "End of Routes" as the last cell in the result list
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"Supercalifragilisticexpialidocious", @"stop_id", nil];
//        [self.busListArray addObject:dict];
////    }
//    //set global variables
//    now = [NSDate date];
//    currComp = [calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:now];
//    databaseDateFormatter1 = [[NSDateFormatter alloc] init];
//    databaseDateFormatter2 = [[NSDateFormatter alloc] init];
//    prettyDateFormatter  = [[NSDateFormatter alloc] init];
//    [databaseDateFormatter2 setDateFormat:@"HH:mm:ss"];
//    [prettyDateFormatter setDateFormat:@"h:mm a"];
//    
//    
//}
//
////return the number of entries in the array
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.busListArray.count;
//}
//
////height of a row
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 78;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    @autoreleasepool {
//        static NSString *cellIdentifier = @"TableCellId";
//        
//        BusListTableCell *tableCell = (BusListTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        
//        //if no cell init it
//        if(tableCell == nil){
//            tableCell= [[BusListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
////        tableCell.delayTime.text=@"15min";
//        //grab out dictionary
//        itemDict = [self.busListArray objectAtIndex:indexPath.row];
//        
//        if([[itemDict objectForKey:@"stop_id"]  isEqual: @"Supercalifragilisticexpialidocious"]){
//            tableCell.timeLeft.text = @"";
//            tableCell.tim.text = @"";
//            
//            tableCell.dir.text = [NSString stringWithFormat:@"End of Routes"];
//            //self.navigationItem.title = [itemDict objectForKey:@"routeTitle"];
//            
//            tableCell.num.text = @"9999";
//            tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            tableCell.userInteractionEnabled = NO;
//            tableCell.accessoryType = UITableViewCellAccessoryNone;
//            return tableCell;
//        }
////        
////        if([[itemDict objectForKey:@"routeDirection"]  isEqual: @"sundayMessage"]){
////            tableCell.timeLeft.text = @"";
////            tableCell.tim.text = @"";
////            
////            tableCell.dir.text = [NSString stringWithFormat:@"No Buses on Sunday"];
////            //self.navigationItem.title = [itemDict objectForKey:@"routeTitle"];
////            
////            tableCell.num.text = @"9999";
////            tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
////            tableCell.userInteractionEnabled = NO;
////            tableCell.accessoryType = UITableViewCellAccessoryNone;
////            return tableCell;
////        }
//
//        
//        //grab our time string for repeated use
//        NSString *dictTime = [itemDict objectForKey:@"arrival_time"];
//  
//        if (pageNumber < 1) {
//            tableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        if (pageNumber > 0) {
//            tableView.allowsSelection = NO;
//        }
//        
//        //prepare variables that will be used
//        NSDate *customizeTime;
//        NSInteger arrivalHour;
//        NSInteger arrivalMin;
//        NSString *test;
//        
//        //determain time information based on HHMM or HMM
////        if (strlen([dictTime cStringUsingEncoding:NSASCIIStringEncoding]) == 3) {
////            arrivalHour = [[dictTime substringToIndex:1] integerValue];
////            arrivalMin =[[dictTime substringFromIndex:1] integerValue];
////            customizeTime = [databaseDateFormatter1 dateFromString:dictTime];
////            
////        } else {
//            arrivalHour = [[dictTime substringToIndex:2] integerValue];
//        
////            arrivalMin =[[dictTime substringFromIndex:2] integerValue];
////            NSRange range = [dictTime rangeOfString:@":"];
//            arrivalMin = [[dictTime substringWithRange:NSMakeRange(3, 2)] integerValue];
//            customizeTime = [databaseDateFormatter2 dateFromString:dictTime];
////        }
////        arrivalMin = 60*arrivalHour + arrivalMin;
//        
//        NSInteger currentHour = [currComp hour];
//        NSInteger currentMin = [currComp minute];
//        currentMin = 60*currentHour + currentMin;
//        
//        //calculate minutes
//        NSInteger minutesRemaining = ((60*arrivalHour) + arrivalMin) - currentMin;
//        
//        //assign all table cell information
//        tableCell.timeLeft.text = [NSString stringWithFormat:@"%d min", minutesRemaining];
//        tableCell.tim.text = [NSString stringWithFormat:@"Time: %@", [prettyDateFormatter stringFromDate:customizeTime]];
//        tableCell.dir.text = [NSString stringWithFormat:@"Trip Id: %@",[itemDict objectForKey:@"trip_id"]];
////        tableCell.dir.text = @"";
////        tableCell.dir.text = [NSString stringWithFormat:@"Direction: %@",[itemDict objectForKey:@"routeDirection"]];
//        
//        tableCell.num.text = [itemDict objectForKey:@"route_id"];
//        tableCell.userInteractionEnabled = YES;
//        
//        return tableCell;
//    }
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSDictionary * dict = [self.busListArray objectAtIndex:indexPath.row];
//    
//    route_id = [dict objectForKey:@"route_id"];
//    service_id = [dict objectForKey:@"service_id"];
//    trip_id = [dict objectForKey:@"trip_id"];
//    stop_id = [dict objectForKey:@"stop_id"];
//    sequence_id = [dict objectForKey:@"stop_sequence"];
//
//    pageNumber++;
//    [self viewDidLoad];
//}
//
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
////method to get back to the first result page
//-(void)firstQuery{
//    pageNumber = 0;
//    [self viewDidLoad];
//}
//
////return to the main menu of the app
//-(void)goHome{
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
