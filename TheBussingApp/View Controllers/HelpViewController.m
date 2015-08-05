//
//  HelpViewController.h
//  KenoshaAreaTransit
//
//  HelpViewController handles the buttons that lead to HowToViewController.
//  The buttons link to web pages located on the device that are displayed on
//  HowToViewController, which is a webview.
//
//  Created by Valerie Berglind on 4/8/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.k
//

#import "HelpViewController.h"
#import "HowToViewController.h"
#import "NSString+FontAwesome.h"
#import "Constants.h"

#define FONT_AWE [UIFont fontWithName:@"SohoGothicStd" size:s]

@interface HelpViewController()

@property(nonatomic) BOOL layedOut;

@end

@implementation HelpViewController
@synthesize howToButton, accessibilityButton,
    aboutButton,
    contactButton;
_Bool isSpanish2;

- (void)styleViews
{
    self.view.backgroundColor = [Constants getBackgroundColor];
    self.view.tintColor = [Constants getAppTintColor];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//         [howToButton setImage:[UIImage imageNamed:@"HelpButtonHowTo.png"] forState:UIControlStateSelected];
//         [howToButton setImage:[UIImage imageNamed:@"HelpButtonHowToClicked.png"] forState:UIControlStateHighlighted];
//        [accessibilityButton setImage:[UIImage imageNamed:@"HelpButtonAccessibility.png"] forState:UIControlStateSelected];
//        [accessibilityButton setImage:[UIImage imageNamed:@"HelpButtonAccessibilityClicked.png"] forState:UIControlStateHighlighted];
//        [aboutButton setImage:[UIImage imageNamed:@"HelpButtonGeneralClicked.png"] forState:UIControlStateHighlighted];
//        [aboutButton setImage:[UIImage imageNamed:@"HelpButtonGeneral.png"] forState:UIControlStateHighlighted];
//        [contactButton setImage:[UIImage imageNamed:@"HelpButtoncontactClicked.png"] forState:UIControlStateHighlighted];
//        [contactButton setImage:[UIImage imageNamed:@"HelpButtonabout.png"] forState:UIControlStateHighlighted];
//        
//        howToButton.adjustsImageWhenHighlighted = YES;
//        accessibilityButton.adjustsImageWhenHighlighted = YES;
//        aboutButton.adjustsImageWhenHighlighted = YES;
//        contactButton.adjustsImageWhenHighlighted = YES;
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"Help View"];
        
        // New SDK versions
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    if(!self.layedOut)
    {
        [self styleButtons];
        self.layedOut = true;
    }
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
    
    awesomeLabel.font = [UIFont fontWithName:@"FontAwesome" size:60];
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
    buttonLabel.textAlignment = NSTextAlignmentLeft;
    buttonLabel.frame = CGRectMake(100, 0, buttonWidth -10, height);
    awesomeLabel.textAlignment = NSTextAlignmentLeft;
    awesomeLabel.frame = CGRectMake(20, 0, buttonWidth, height);
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
        shadowLayer.borderColor =[[UIColor yellowColor] CGColor];
    }
    else{
        shadowLayer.borderColor =[[UIColor blackColor] CGColor];
    }
    shadowLayer.borderWidth = 5;
    shadowLayer.frame= CGRectMake(0.0f, button.frame.size.height - 5, button.frame.size.width, 5.0f);
    
    [button.layer addSublayer:gradientLayer];
    [button.layer addSublayer:shadowLayer];
    // Add label to button
    [button addSubview:buttonLabel];
    [button addSubview:awesomeLabel];
} // End formatLabelForButton


-(IBAction)unwindToHelpPage:(UIStoryboardSegue *)sender{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Help Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self styleViews];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)styleButtons
{
    // Do any additional setup after loading the view.
    NSString *language = [[NSLocale preferredLanguages]objectAtIndex:0];
    if([language  isEqual: @"es"]){
        isSpanish2 = true;
    }
    else{
        isSpanish2 = false;
    }
    //set the buttons to Spanish if the user's language is Spanish
    if(isSpanish2){
        //        [aboutButton setImage:[UIImage imageNamed:@"HelpButtonGeneralEsp.png"] forState:UIControlStateNormal];
        //        [howToButton setImage:[UIImage imageNamed:@"HelpButtonHowToEsp.png"] forState:UIControlStateNormal];
        //        [accessibilityButton setImage:[UIImage imageNamed:@"HelpButtonAccessibilityEsp.png"] forState:UIControlStateNormal];
        //        [contactButton setImage:[UIImage imageNamed:@"HelpButtonContactEsp.png"] forState:UIControlStateNormal];
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:50 andText:@"Sobre" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"Cómo" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accesibilidad" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contactar" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:false];
    }
    else{
        
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:50 andText:@"About" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"How To" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accessibility" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:false];
        
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contact" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:false];
    }
}

//set "Accessibility" button image back to unclicked version
- (IBAction)touchUpAccessibilityButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accesibilidad" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:false];
    }
    else{
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accessibility" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:false];
    }
}

//set "Accessibility" button image to clicked version
- (IBAction)clickedAccessibilityButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accesibilidad" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:true];
    }
    else{
        [self 	formatLabelForButton:accessibilityButton withHeight:accessibilityButton.frame.size.height andVerticalOffset:0 andText:@"Accessibility" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaCogs] withTag:0 buttonClicked:true];
    }
}

//set "How To" button image back to unclicked version
- (IBAction)clickedHowToButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"Cómo" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:true];
    }
    else{
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"How To" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:true];
    }
}

//set "How To" button image to clicked version
- (IBAction)touchUpHowToButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"Cómo" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:false];
    }
    else{
        [self 	formatLabelForButton:howToButton withHeight:howToButton.frame.size.height andVerticalOffset:0 andText:@"How To" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaBook] withTag:0 buttonClicked:false];
    }
    
    [self performSegueWithIdentifier:@"presentTutorialFromHelp" sender:self];
}

//set "About" button image to clicked version
- (IBAction)clickedAboutButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:50 andText:@"Sobre" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:true];
    }
    else{
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:0 andText:@"About" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:true];
    }
}

//set "About" button image back to unclicked version
- (IBAction)touchUpAboutButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:50 andText:@"Sobre" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
    }
    else{
        [self 	formatLabelForButton:aboutButton withHeight:aboutButton.frame.size.height andVerticalOffset:0 andText:@"About" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaInfoCircle] withTag:0 buttonClicked:false];
    }
}

//set "Contact" button image to clicked version
- (IBAction)clickedContactButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contactar" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:true];
    }
    else{
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contact" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:true];
    }
}

//set "Contact" button image back to unclicked version
- (IBAction)touchUpContactButton:(id)sender {
    if(isSpanish2){
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contactar" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:false];
    }
    else{
        [self 	formatLabelForButton:contactButton withHeight:contactButton.frame.size.height andVerticalOffset:0 andText:@"Contact" withFontSize:20 withFontColor:[UIColor blueColor] fontAwesome:[NSString awesomeIcon:FaPhone] withTag:0 buttonClicked:false];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //check if "About" button has been pressed
    if ([[segue identifier] isEqualToString:@"showAboutText"])
    {
        HowToViewController *howToViewController =
        [segue destinationViewController];
        
        //set the button value to 1
        howToViewController.buttonValue = 1;
    }
    
    //check if "How To" button has been pressed
    if ([[segue identifier] isEqualToString:@"showHowToText"])
    {
        HowToViewController *howToViewController =
        [segue destinationViewController];
        
        //set the button value to 2
        howToViewController.buttonValue = 2;
    }
    
    //check if "Accessibility" button has been pressed
    if ([[segue identifier] isEqualToString:@"showAccessibilityText"])
    {
        HowToViewController *howToViewController =
        [segue destinationViewController];
        
        //set the button value to 3
        howToViewController.buttonValue = 3;
    }
    
    //check if "Contact" button has been pressed
    if ([[segue identifier] isEqualToString:@"showContactText"])
    {
        HowToViewController *howToViewController =
        [segue destinationViewController];
        
        //set the button value to 4
        howToViewController.buttonValue = 4;
    }
}



@end
