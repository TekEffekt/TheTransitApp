//
//  TutorialViewController.m
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 4/29/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "TutorialViewController.h"
#import "EAIntroView.h"
#import "Constants.h"
#import "Styleable.h"

@interface TutorialViewController () <EAIntroDelegate, StylesItself>

@property(nonatomic) BOOL navigationBarWasHidden;

@end

@implementation TutorialViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)styleViews
{
    self.view.tintColor = [Constants getAppTintColor];
    self.view.backgroundColor = [Constants getBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self styleViews];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello there!";
    page1.desc = [Constants getTextForIndex:0];
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 273, 108)];
    bannerView.image = [UIImage imageNamed:@"App Banner.png"];
    page1.titleIconView = bannerView;
    page1.titleIconPositionY = self.view.frame.size.height/2 - page1.titleIconView.frame.size.height;
    
    int pageWidth;
    int pageHeight;
    
    #ifdef Kenosha
        pageWidth = 288;
        pageHeight = 360;
        
        if(self.view.frame.size.height < 568)
        {
            NSLog(@"%f", self.view.frame.size.height);
            pageWidth = 220;
            pageHeight = 276;
        }
    #else
        pageWidth = 200;
        pageHeight = 370;
        
        if(self.view.frame.size.height < 568)
        {
            NSLog(@"%f", self.view.frame.size.height);
            pageWidth = 150;
            pageHeight = 283;
        }
    #endif
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"\"What stops are near me?\"";
    page2.desc = [Constants getTextForIndex:1];
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    UIImageView *screenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView.image = [UIImage imageNamed:@"screen1"];
    page2.titleIconView = screenView;
    page2.titleIconPositionY = page2.titleIconPositionY - 20;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"A Useful Map";
    page3.desc = [Constants getTextForIndex:2];
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    UIImageView *screenView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView2.image = [UIImage imageNamed:@"screen2"];
    page3.titleIconView = screenView2;
    page3.titleIconPositionY = page3.titleIconPositionY - 20;
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Get Route Lines";
    page4.desc = [Constants getTextForIndex:3];
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    UIImageView *screenView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView3.image = [UIImage imageNamed:@"screen3"];
    page4.titleIconView = screenView3;
    page4.titleIconPositionY = page4.titleIconPositionY - 20;
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = @"Touch it!";
    page5.desc = [Constants getTextForIndex:4];
    page5.bgImage = [UIImage imageNamed:@"bg1"];
    UIImageView *screenView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView4.image = [UIImage imageNamed:@"screen4"];
    page5.titleIconView = screenView4;
    page5.titleIconPositionY = page5.titleIconPositionY - 20;
    
    EAIntroPage *page6 = [EAIntroPage page];
    page6.title = @"The bus stops as a list";
    page6.desc = [Constants getTextForIndex:5];
    page6.bgImage = [UIImage imageNamed:@"bg2"];
    UIImageView *screenView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView5.image = [UIImage imageNamed:@"screen5"];
    page6.titleIconView = screenView5;
    page6.titleIconPositionY = page6.titleIconPositionY - 20;
    
    EAIntroPage *page7 = [EAIntroPage page];
    page7.title = @"Incoming Buses";
    page7.desc = [Constants getTextForIndex:6];
    page7.bgImage = [UIImage imageNamed:@"bg3"];
    UIImageView *screenView6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView6.image = [UIImage imageNamed:@"screen6"];
    page7.titleIconView = screenView6;
    page7.titleIconPositionY = page7.titleIconPositionY - 20;
    
    EAIntroPage *page8 = [EAIntroPage page];
    page8.title = @"QR Scanning";
    page8.desc = [Constants getTextForIndex:7];
    page8.bgImage = [UIImage imageNamed:@"bg4"];
    UIImageView *screenView7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView7.image = [UIImage imageNamed:@"screen7"];
    page8.titleIconView = screenView7;
    page8.titleIconPositionY = page8.titleIconPositionY - 20;
    
    EAIntroPage *page9 = [EAIntroPage page];
    page9.title = @"Routing";
    page9.desc = [Constants getTextForIndex:8];
    page9.bgImage = [UIImage imageNamed:@"bg1"];
    UIImageView *screenView8= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView8.image = [UIImage imageNamed:@"screen8"];
    page9.titleIconView = screenView8;
    page9.titleIconPositionY = page9.titleIconPositionY - 20;
    
    EAIntroPage *page10 = [EAIntroPage page];
    page10.title = @"Getting Help";
    page10.desc = [Constants getTextForIndex:9];
    page10.bgImage = [UIImage imageNamed:@"bg2"];
    UIImageView *screenView9 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView9.image = [UIImage imageNamed:@"screen9"];
    page10.titleIconView = screenView9;
    page10.titleIconPositionY = page10.titleIconPositionY - 20;
    
    EAIntroPage *page11 = [EAIntroPage page];
    page11.title = @"Getting back to this tutorial";
    page11.desc = [Constants getTextForIndex:10];
    page11.bgImage = [UIImage imageNamed:@"bg3"];
    UIImageView *screenView10 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
    screenView10.image = [UIImage imageNamed:@"screen10"];
    page11.titleIconView = screenView10;
    page11.titleIconPositionY = page11.titleIconPositionY - 20;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5,page6,page7,page8,page9, page10, page11]];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
}

- (void)introDidFinish:(EAIntroView *)introView
{
    self.navigationController.navigationBarHidden = self.navigationBarWasHidden;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex
{
    self.navigationBarWasHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = YES;
}

@end
