//
//  HomeViewController.h
//  KenoshaAreaTransit
//
//  HomeViewController is the home page logic of the  App.  This view
//  controller handles the logic of button presses, and hands the application off
//  to other view controllers.  The ZBar barcode scanner is handled in this view
//  controller.
//
//  Created by Richard Arthur Lebbin III on 2/11/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import "HomeViewController.h"
#import "BusRouteListViewController.h"
#import "HelpViewController.h"
#import "NearMeTableViewController.h"
#import "NearMeMapViewController.h"
#import "AppDelegate.h"
#import "NSString+FontAwesome.h"
#import "IncomingBusesViewController.h"
#import "WECodeScannerView.h"
#import "TutorialViewController.h"
#import "Constants.h"
#import "Styleable.h"

#define FONT_AWE [UIFont fontWithName:@"SohoGothicStd" size:s]

@interface HomeViewController() <WECodeScannerViewDelegate, CLLocationManagerDelegate, StylesItself>

@property(strong, nonatomic) NSArray *incomingBuses;
@property(strong, nonatomic) NSString *selectedStopName;
@property (nonatomic, strong) WECodeScannerView *codeScannerView;
@property(nonatomic, strong)  NSString *qrCode;
@property(nonatomic) BOOL scanned;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic) BOOL loaded;

@end

@implementation HomeViewController
@synthesize btnHelp, btnRoute, btnScan, btnGPS, btnPayment, logoBanner;
_Bool isSpanish;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(isSpanish){
//            [btnRoute setImage:[UIImage imageNamed:@"RouteButtonEsp.png"] forState:UIControlStateSelected];
//            [btnRoute setImage:[UIImage imageNamed:@"RouteButtonClickedEsp.png"] forState:UIControlStateHighlighted];
//            btnRoute.adjustsImageWhenHighlighted = YES;
//
//            [btnRoute setImage:[UIImage imageNamed:@"ScanButtonEsp.png"] forState:UIControlStateSelected];
//            [btnScan setImage:[UIImage imageNamed:@"ScanButtonClickedEsp.png"] forState:UIControlStateHighlighted];
//            btnScan.adjustsImageWhenHighlighted = YES;
//            
//            
//            [btnHelp setImage:[UIImage imageNamed:@"HelpButtonEsp.png"] forState:UIControlStateSelected];
//            [btnHelp setImage:[UIImage imageNamed:@"HelpButtonClickedEsp.png"] forState:UIControlStateHighlighted];
//            btnHelp.adjustsImageWhenHighlighted = YES;
        }
        else{
//            [btnRoute setImage:[UIImage imageNamed:@"ScanButton.png"] forState:UIControlStateSelected];
//            [btnRoute setImage:[UIImage imageNamed:@"RouteButton.png"] forState:UIControlStateSelected];
//            [btnHelp setImage:[UIImage imageNamed:@"HelpButton.png"] forState:UIControlStateSelected];
//            
//            [btnScan setImage:[UIImage imageNamed:@"ScanButtonClicked.png"] forState:UIControlStateHighlighted];
//            [btnRoute setImage:[UIImage imageNamed:@"RouteButtonClicked.png"] forState:UIControlStateHighlighted];
//            [btnHelp setImage:[UIImage imageNamed:@"HelpButtonClicked.png"] forState:UIControlStateHighlighted];
//            
//            btnScan.adjustsImageWhenHighlighted = YES;
//            btnRoute.adjustsImageWhenHighlighted = YES;
//            btnHelp.adjustsImageWhenHighlighted = YES;
        }
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"Home View"];
        
        // New SDK versions
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
    }
    return self;
}

/*************************************
 These methods are designed to simply
 change the images of the buttons when
 the user touches them
 ************************************/

//change image when scan button is clicked
-(IBAction)touchScan:(id)sender {
    if(isSpanish){
        //[btnScan setImage:[UIImage imageNamed:@"ScanButtonClickedEsp.png"] forState:UIControlStateNormal];
    }
    else{
        //[btnScan setImage:[UIImage imageNamed:@"ScanButtonClicked.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnScan withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Scan" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCameraRetro] withTag:0 buttonClicked:true];
    }
    self.scanned = NO;
}

//change image back to unclicked version when scan button is no longer clicked
-(IBAction)upScan:(id)sender {
    if(isSpanish){
        //[btnScan setImage:[UIImage imageNamed:@"ScanButtonEsp.png"] forState:UIControlStateNormal];
    }
    else{
        //[btnScan setImage:[UIImage imageNamed:@"ScanButton.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnScan withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Scan" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCameraRetro] withTag:0 buttonClicked:false];
    }
}


-(IBAction)upInsideScan:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(cancelScan)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.codeScannerView = [[WECodeScannerView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    self.codeScannerView.delegate = self;
    self.codeScannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.codeScannerView];
    [self.codeScannerView start];
}

- (void)startScanner
{
    self.startScan = NO;
    
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(cancelScan)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.codeScannerView = [[WECodeScannerView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    self.codeScannerView.delegate = self;
    self.codeScannerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.codeScannerView];
    [self.codeScannerView start];
}

- (void)scannerView:(WECodeScannerView *)scannerView didReadCode:(NSString *)code
{
    if(!self.scanned)
    {
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getNearbyRoutesWithQRData) userInfo:nil repeats:NO];
        self.qrCode = code;
        self.scanned = YES;
    }
}

- (void)cancelScan
{
    [self.codeScannerView stop];
    self.codeScannerView.alpha = 0.0;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = NO;
}

-(IBAction)upInsideGPS:(id)sender {
    @autoreleasepool {
        ConnectionManager *conman = [ConnectionManager new];
        [conman post_request:@"" :@"" :@"CHECK_IN"];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        {
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            } else
            {
                [self.locationManager startUpdatingLocation];
            }
        } else if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways)
        {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Need permission!" message:@"In order to use the Near Me feature, go into your settings and allow this app to use your location." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            controller.view.tintColor = [UIColor blueColor];
            
            [controller addAction:okAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
    
    // Get Nearby Routes is called in didChangeStatus method
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self performSegueWithIdentifier:@"showGpsPage" sender:self];
    }
}

//change image when route button is clicked
-(IBAction)touchRoute:(id)sender {
    if(isSpanish){
        //[btnRoute setImage:[UIImage imageNamed:@"RouteButtonClickedEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnRoute withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Recorrer" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:true];
    }
    else{
        //[btnRoute setImage:[UIImage imageNamed:@"RouteButtonClicked.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnRoute withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Route" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:true];
    }
}

//set button image back to unclicked version
-(IBAction)upRoute:(id)sender {
    if(isSpanish){
        [self formatLabelForButton:btnRoute withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Recorrer" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:false];
    }
    else{
        //[btnRoute setImage:[UIImage imageNamed:@"RouteButton.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnRoute withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Route" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:false];
    }
    
    [self launchGoogleMaps];
}

- (void)launchGoogleMaps
{
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"http://maps.apple.com/"]]) {
        ConnectionManager *conman = [ConnectionManager new];
        [conman update_gps];
        
        double myLat = [[conman get_latitude] doubleValue];
        double myLon = [[conman get_longitude] doubleValue];
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&dirflg=r", myLat, myLon]]];
    } else
    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Uh oh!" message:@"You need to install the Google Maps app to use this feature!" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        }];
//        
//        UIAlertAction *openStoreAction = [UIAlertAction actionWithTitle:@"Open Store" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            NSString *iTunesLink = @"https://itunes.apple.com/us/app/google-maps/id585027354?mt=8";
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
//        }];
//        
//        [alert addAction:okAction];
//        [alert addAction:openStoreAction];
//        
//        alert.view.tintColor = [UIColor blueColor];
//        
//        [self presentViewController:alert animated:YES completion:nil];
    }
}

//opens itunes to download Google maps
-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 1){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms://itunes.com/apps/googlemaps"]];
//    }
}

//change button image when help button is clicked
-(IBAction)touchHelp:(id)sender {
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClickedEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:true];
    }
    else{
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClicked.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:true];
    }
}

//set button image back to unclicked version
-(IBAction)upHelp:(id)sender {
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
    }
    else{
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButton.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
    }
}

-(IBAction)touchGPS:(id)sender{
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClickedEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnGPS withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:true];
    }
    else{
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClicked.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnGPS withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:true];
    }
}

-(IBAction)upGPS:(id)sender{
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnGPS withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:false];
    }
    else{
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButton.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnGPS withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:false];
    }

}

- (IBAction)touchHelp2:(UIButton *)sender
{
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClickedEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnPayment withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Ayuda" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:true];
    }
    else{
        [self formatLabelForButton:btnPayment withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Help" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:true];
    }
}


- (IBAction)upHelp2:(UIButton *)sender
{
    if(isSpanish){
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonClickedEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnPayment withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Ayuda" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:false];
    }
    else{
        [self formatLabelForButton:btnPayment withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Help" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:false];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Home Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
	UIGraphicsBeginImageContext(newSize);
    
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return newImage;
}

- (void) formatLabelForButton: (UIButton *) button withHeight: (double) height andVerticalOffset: (double) offset andText: (NSString *) labelText withFontSize: (double) fontSize withFontColor: (UIColor *) color fontAwesome:(NSString *) fontAwesome withTag: (NSInteger) tagNumber buttonClicked: (Boolean) isClicked{
    
    for (UIView *view in button.subviews)
    {
        [view removeFromSuperview];
    }
    
    button.layer.sublayers = nil;

    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    button.layer.masksToBounds= YES;
    button.layer.shadowRadius=5.0f;
    button.layer.shadowOpacity=1.0;
    button.layer.borderWidth= .5f;
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    
    // Get width of button
    double buttonWidth= button.frame.size.width;
    
    // Initialize buttonLabel
    UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonWidth, height)];
    UILabel *awesomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, buttonWidth, height)];
    
    // set font color of label
    buttonLabel.textColor = color;
    
    awesomeLabel.font = [UIFont fontWithName:@"FontAwesome" size:50];
    awesomeLabel.text = fontAwesome;
    
    // Set background color, text, tag, and font
    //buttonLabel.backgroundColor = [UIColor whiteColor];
    //buttonLabel.text = labelText;
    buttonLabel.text = labelText;
    buttonLabel.font = [UIFont fontWithName:@"OriyaSangamMN-Bold" size:30];
    buttonLabel.textColor = [UIColor colorWithRed:.13 green:.12 blue:.27 alpha:1];
    //buttonLabel.layer.borderWidth= .5f;
    buttonLabel.layer.cornerRadius=5;
    buttonLabel.tag = tagNumber;

    // Center label
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.frame = CGRectMake(0, 25, buttonWidth -10, height);
    awesomeLabel.textAlignment = NSTextAlignmentCenter;
    awesomeLabel.frame = CGRectMake(0, -20, buttonWidth, height);
    awesomeLabel.textColor = [UIColor colorWithRed:.13 green:.12 blue:.27 alpha:1];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = button.layer.bounds;
    if(isClicked){
        gradientLayer.colors = [NSArray arrayWithObjects:
                                (id)[UIColor colorWithWhite:0.4f alpha:1.0f].CGColor,
                                (id)[UIColor colorWithWhite:1.0f alpha:0.0f].CGColor,
                                nil];
        
        gradientLayer.locations = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:0.4f],
                                   [NSNumber numberWithFloat:1.0f],
                                   nil];
    }
    else{
        gradientLayer.colors = [NSArray arrayWithObjects:
                                (id)[UIColor colorWithWhite:1.0f alpha:0.0f].CGColor,
                                (id)[UIColor colorWithWhite:0.4f alpha:1.0f].CGColor,
                                nil];
        
        gradientLayer.locations = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:0.4f],
                                   [NSNumber numberWithFloat:1.0f],
                                   nil];

    }
    
    gradientLayer.cornerRadius = button.layer.cornerRadius;
    
    
    
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.backgroundColor = [[UIColor clearColor] CGColor];
    if(isClicked){
        shadowLayer.borderColor =[[Constants getAppTintColor] CGColor];
    }
    else{
        shadowLayer.borderColor =[[UIColor blackColor] CGColor];
    }
    shadowLayer.borderWidth = 5;
    shadowLayer.frame= CGRectMake(0.0f, button.frame.size.height - 5, button.frame.size.width, 5.0f);
    if([awesomeLabel.text  isEqual: [NSString awesomeIcon:FaInfoCircle]]){
        //shadowLayer.backgroundColor = [[UIColor clearColor] CGColor];
        button.layer.shadowColor = [UIColor clearColor].CGColor;
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderWidth = 0;
        //button.frame = CGRectMake(5, 20, awesomeLabel.frame.size.width, awesomeLabel.frame.size.height);
        awesomeLabel.font = [UIFont fontWithName:@"FontAwesome" size:20];
        awesomeLabel.frame = CGRectMake(20, 12, awesomeLabel.frame.size.width, awesomeLabel.frame.size.height);
    }
    else{
        [button.layer addSublayer:gradientLayer];
        [button.layer addSublayer:shadowLayer];
    }
    // Add label to button
    [button addSubview:buttonLabel];
    [button addSubview:awesomeLabel];
} // End formatLabelForButton

//hide the navigation bar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    if(![[NSUserDefaults standardUserDefaults] integerForKey:@"First Time"])
    {
        [self performSegueWithIdentifier:@"presentTutorial" sender:self];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"First Time"];
    }
    
    if(self.startScan)
    {
        [self startScanner];
    }
}

- (void)viewDidLayoutSubviews
{
    if(!self.loaded)
    {
        [self styleViews];
        self.loaded = YES;
        NSLog(@"Loaded");
    }
}

//method needed whenever another view controller is returning to home
-(IBAction)unwindToMainMenu:(UIStoryboardSegue *)sender{
}

//called when opening a new view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OpenIncomingBuses"])
    {
        IncomingBusesViewController *controller = segue.destinationViewController;
        controller.stopName = self.selectedStopName;
        controller.incomingBuses = self.incomingBuses;
    }
}

//open the help view controller when the help button is pressed
-(IBAction)goToHelpPage:(id)sender{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    //check if iPhone has a 3.5 inch screen
    if(result.height == 480)
    {
        [self performSegueWithIdentifier:@"To helpPage35" sender:self];
    }
    //is not 3.5 inch screen, must be the 4 inch screen
    else
    {
        [self performSegueWithIdentifier:@"To helpPage4" sender:self];
    }
}

- (void)getNearbyRoutes
{
//    dispatch_queue_t queue = dispatch_queue_create("Get Routes Queue", NULL);
//    dispatch_async(queue, ^{
//        DatabaseManager *db;
//        db = [DatabaseManager getSharedInstance];
//        self.nearbyRoutes = [db getNearbyRoutes];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });
}

- (void)getNearbyRoutesWithQRData
{
    [self.codeScannerView stop];
    self.codeScannerView.alpha = 0.0;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = NO;
    
    NSString *code = self.qrCode;
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"cccc"];
    NSString *weekday = [[dateFormatter stringFromDate:now] lowercaseString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    
    NSString *stopId = [DatabaseManager validateValue:code];
    
    dispatch_queue_t queue = dispatch_queue_create("Get Routes", NULL);
    dispatch_async(queue, ^{
        DatabaseManager *db;
        db = [DatabaseManager getSharedInstance];
        self.incomingBuses = [db getIncomingBusesForStop:stopId AtTime:currentTimeString AndDay:weekday];
        self.selectedStopName = [self.incomingBuses firstObject][0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"OpenIncomingBuses" sender:self];
        });
    });
}

- (void)styleViews
{
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    /**********Commented out due to warning**************/
    //AppDelegate *appDelegate = [AppDelegate alloc];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //    [locationManager requestWhenInUseAuthorization];
    // Check for iOS 8
    
    
    if([language  isEqual: @"es"]){
        isSpanish = true;
    }
    else{
        isSpanish = false;
    }
    if(isSpanish){
        //[btnScan setImage:[UIImage imageNamed:@"ScanButtonEsp.png"] forState:UIControlStateNormal];
        [self 	formatLabelForButton:btnScan withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Escanear" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCameraRetro] withTag:0 buttonClicked:false];
        //[btnRoute setImage:[UIImage imageNamed:@"RouteButtonEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnRoute withHeight:btnRoute.frame.size.height andVerticalOffset:0 andText:@"Recorrer" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:false];
        //[btnHelp setImage:[UIImage imageNamed:@"HelpButtonEsp.png"] forState:UIControlStateNormal];
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:15 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
        [self formatLabelForButton:btnGPS withHeight:btnGPS.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:false];
        //@TODO FIX
        //Altered this to show help screen
        [self formatLabelForButton:btnPayment withHeight:btnPayment.frame.size.height andVerticalOffset:0 andText:@"Ayuda" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:false];
    }
    else{
        [self formatLabelForButton:btnScan withHeight:btnScan.frame.size.height andVerticalOffset:0 andText:@"Scan" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCameraRetro] withTag:0 buttonClicked:false];
        
        [self formatLabelForButton:btnRoute withHeight:btnRoute.frame.size.height andVerticalOffset:0 andText:@"Route" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaRoad] withTag:0 buttonClicked:false];
        
        [self formatLabelForButton:btnHelp withHeight:btnHelp.frame.size.height andVerticalOffset:0 andText:@"" withFontSize:15 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
        
        [self formatLabelForButton:btnGPS withHeight:btnGPS.frame.size.height andVerticalOffset:0 andText:@"GPS" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCompass] withTag:0 buttonClicked:false];
        //@TODO FIX
        //Altered this to show help screen
        [self formatLabelForButton:btnPayment withHeight:btnPayment.frame.size.height andVerticalOffset:0 andText:@"Help" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaQuestionCircle] withTag:0 buttonClicked:false];
    }
    
    self.view.backgroundColor = [Constants getBackgroundColor];
    self.view.tintColor = [Constants getAppTintColor];
    self.navigationController.navigationBar.tintColor = [Constants getAppTintColor];
    self.navigationController.navigationBar.barTintColor = [Constants getBackgroundColor];
}

@end
