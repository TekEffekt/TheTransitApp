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

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "ConnectionManager.h"

@interface ExternalViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webViewExternal;

@property int buttonValue;

@end
