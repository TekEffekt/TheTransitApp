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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "RootViewController.h"
#import "ConnectionManager.h"
#import <CoreLocation/CoreLocation.h>


@interface HomeViewController : RootViewController
@property (strong, nonatomic) IBOutlet UIButton *btnGPS;

@property (nonatomic) IBOutlet UIButton *btnScan;
@property (nonatomic) IBOutlet UIButton *btnRoute;
@property (nonatomic) IBOutlet UIButton *btnHelp;
@property (strong, nonatomic) IBOutlet UIButton *btnPayment;
@property (strong, nonatomic) IBOutlet UIButton *logoBanner;

// Touch events to change button images
-(IBAction)touchScan:(id)sender;
-(IBAction)upScan:(id)sender;
-(IBAction)touchRoute:(id)sender;
-(IBAction)upInsideScan:(id)sender;
-(IBAction)upRoute:(id)sender;
-(IBAction)touchHelp:(id)sender;
-(IBAction)upHelp:(id)sender;
-(IBAction)touchGPS:(id)sender;
-(IBAction)upGPS:(id)sender;
-(IBAction)upInsideGPS:(id)sender;
-(IBAction)touchPayment:(id)sender;
-(IBAction)upPayment:(id)sender;
-(void)formatAdvertisement;


//methods
-(UIView *)createZbarOverlay;
-(void) formatLabelForButton: (UIButton *) button withHeight: (double) height andVerticalOffset: (double) offset andText: (NSString *) labelText withFontSize: (double) fontSize withFontColor: (UIColor *) color fontAwesome:(NSString *) formatAsBold withTag: (NSInteger) tagNumber buttonClicked: (Boolean) isClicked;
@end
