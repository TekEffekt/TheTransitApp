//
//  HowToViewController.h
//  KenoshaAreaTransit
//
//  HowToViewController is a webview in which the help pages are displayed on
//  the device.  The help pages are local .html documents, and
//  HowToViewController gets the information on which to display from
//  HelpViewController.
//
//  Created by Valerie Berglind on 4/17/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import "HowToViewController.h"
_Bool isSpanish4;

@interface HowToViewController()

@end

@implementation HowToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"How To View"];
        
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
           value:@"How To Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad
{
    //check if the user's language setting is set to Spanish
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    if([language  isEqual: @"es"]){
        isSpanish4 = true;
    }
    else{
        isSpanish4 = false;
    }

    NSString *stringVariable;
    
    //check which value was assigned based on the button that was pressed in the HelpViewController.m
    if(_buttonValue == 1){
        //set the proper language for the about button
        if(isSpanish4){
            stringVariable = @"spanishabout";
        }
        else{
            stringVariable = @"about";
        }
    }
    if(_buttonValue == 2){
        //set the proper language for the how to button
        if(isSpanish4){
            stringVariable = @"spanishHowTo";
        }
        else{
            stringVariable = @"how_to";
        }
    }
    if(_buttonValue == 3){
        //set the proper language for the accessibility button
        if(isSpanish4){
            stringVariable = @"spanishAccessibility";
        }
        else{
            stringVariable = @"accessibility";
        }
    }
    //set the proper language for the contact button
    if(_buttonValue == 4){
        if(isSpanish4){
            stringVariable = @"spanishContact";
        }
        else{
            stringVariable = @"contact";
        }
    }
    
    //open the html based on which button was pressed(will be using stringValue to find this out)
    NSString *indexPath = [[NSBundle mainBundle] pathForResource: stringVariable ofType:@"html" inDirectory: nil];
    [_webViewHowTo loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    [super viewDidLoad];
}

//go back to the help page
-(IBAction)unwindToHelpPage:(UIStoryboardSegue *)sender{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
