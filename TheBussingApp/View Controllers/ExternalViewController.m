//
//  ExternalViewController
//  KenoshaAreaTransit
//
//  Created by Valerie Berglind on 4/17/14.
//  Copyright (c) 2014 Matthew Zygowicz. All rights reserved.
//

#import "ExternalViewController.h"

_Bool isSpanish3;

@interface ExternalViewController ()

@end

@implementation ExternalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"External Webview"];
        
        // New SDK versions
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"External Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO;
    //check if the user's language setting is set to Spanish
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    ConnectionManager *conman = [ConnectionManager new];
    if([language  isEqual: @"es"]){
        isSpanish3 = true;
    }
    else{
        isSpanish3 = false;
    }
    
    //check which value was assigned based on the button that was pressed in the HelpViewController.m
    NSString *indexPath = @"";
    NSString *body = @"";
    if(_buttonValue == 1){
        //is the  Banner clicked
         indexPath = @"http://www.kenosha.org/departments/transportation/";
    }
    if(_buttonValue == 2){
        //is the route button clicked
        indexPath = @"https://www.google.com/maps/dir/42.8052181,-87.8133025/McDonald's,+5125+Douglas+Ave,+Racine,+WI+53402,+United+States/@42.7962376,-87.812961,16z/data=!4m6!4m5!1m0!1m2!1m1!1s0x8805410c5e27879b:0xf64a8f1f04c1c9f0!3e2";
    }
    if(_buttonValue == 3){
        indexPath = @"http://70.63.28.41/api/navigation";
        
        [conman update_gps];
        
        body = [NSString stringWithFormat: @"latitude=%@&longitude=%@", [conman get_latitude],[conman get_longitude]];
        
    }
    
//    //make a new back button for the navigation bar
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
//                                                                  target:self
//                                                                  action:@selector(unwindToMainPage:)];
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.leftBarButtonItem = backButton;
    
    //prepare possible post vars
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:indexPath]];
    if(_buttonValue ==3)
        [request setHTTPMethod: @"POST"];
    else{
        [request setHTTPMethod:@"GET"];
    }
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    

    [_webViewExternal loadRequest:request];
    [super viewDidLoad];
}

//go back to the help page
-(IBAction)unwindToMainPage:(UIStoryboardSegue *)sender{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
