//
//  HelpViewController.h
//  KenoshaAreaTransit
//
//  HelpViewController handles the buttons that lead to HowToViewController.
//  The buttons link to web pages located on the device that are displayed on
//  HowToViewController, which is a webview.
//
//  Created by Valerie Berglind on 4/8/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "RootViewController.h"
#import "Styleable.h"

@interface HelpViewController : RootViewController <StylesItself>
@property (nonatomic) IBOutlet UIButton *howToButton;
@property (strong, nonatomic) IBOutlet UIButton *accessibilityButton;
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;

-(void) formatLabelForButton: (UIButton *) button withHeight: (double) height andVerticalOffset: (double) offset andText: (NSString *) labelText withFontSize: (double) fontSize withFontColor: (UIColor *) color fontAwesome:(NSString *) formatAsBold withTag: (NSInteger) tagNumber buttonClicked: (Boolean) isClicked;
@end
