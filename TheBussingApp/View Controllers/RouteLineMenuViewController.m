//
//  RouteLineMenuViewController.m
//  Racine-Transit
//
//  Created by Kyle Zawacki on 6/24/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "RouteLineMenuViewController.h"
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"
#import "Constants.h"

@interface RouteLineMenuViewController ()

@property(strong, nonatomic) UIVisualEffectView *backgroundBlur;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *routeButtonContainers;
@property (weak, nonatomic) IBOutlet UIButton *xButton;
@property (weak, nonatomic) IBOutlet UIButton *enableButton;
@property (weak, nonatomic) IBOutlet UIButton *disableButton;

@end

@implementation RouteLineMenuViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)styleViews
{
    self.xButton.tintColor = [Constants getAppTintColor];
    self.view.tintColor = [Constants getAppTintColor];
    self.enableButton.tintColor = [Constants getAppTintColor];
    self.disableButton.tintColor = [Constants getAppTintColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.backgroundBlur = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.backgroundBlur.frame = self.view.bounds;
    
    [self.view insertSubview:self.backgroundBlur atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpButtonColors];
    [self styleViews];
}

- (void)routeButtonPressed:(BFPaperButton*)button
{
    int index = [self.routeButtonContainers indexOfObject:button.superview];
    NSLog(@"Index: %d", index);
    if(button.backgroundColor != [UIColor lightGrayColor])
    {
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self changePolylineOnDelegate:NO atIndex: index];
    } else
    {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [Constants getRouteColorForRoute: [Constants getRoutesFromOrderedIndex:index]];
        [self changePolylineOnDelegate:YES atIndex: index];
    }
}

- (IBAction)xButtonTouched:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enableAllPressed:(UIButton *)sender
{
    for(int i = 0; i <[Constants getListOfRouteNames].count; i++)
    {
        UIView *view = self.routeButtonContainers[i];
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        if(button.backgroundColor == [UIColor lightGrayColor])
        {
            button.backgroundColor = [Constants getRouteColorForRoute: [Constants getRoutesFromOrderedIndex:i]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self changePolylineOnDelegate:YES atIndex:(int)[self.routeButtonContainers indexOfObject:view]];
    }
}

- (IBAction)disableAll:(UIButton *)sender
{
    for(int i = 0; i <[Constants getListOfRouteNames].count; i++)
    {
        UIView *view = self.routeButtonContainers[i];
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        if(button.backgroundColor != [UIColor lightGrayColor])
        {
            button.backgroundColor = [UIColor lightGrayColor];
        }
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self changePolylineOnDelegate:NO atIndex:(int)[self.routeButtonContainers indexOfObject:view]];
    }
}

- (void)changePolylineOnDelegate:(BOOL)enable atIndex:(int)index
{
    self.enable = enable;
    self.index = index;
    NSLog(@"Index: %d Enable: %@", index, enable ? @"YES": @"NO");
    [(NSObject*)self.delegate performSelectorOnMainThread:@selector(changePolyine) withObject:self waitUntilDone:YES];
}

- (void)setupButtons
{
    for(int i = 0; i < [Constants getListOfRouteNames].count; i++)
    {
        UIView *container = (UIView*)self.routeButtonContainers[i];
        BFPaperButton *button = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
        NSString *routeString = [Constants getRoutesFromOrderedIndex:i];
        routeString = [Constants getShortHandForRoute:routeString];
        [button setTitle:routeString forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor lightGrayColor];
        button.tapCircleColor = [Constants getRouteColorForRoute: [Constants getRoutesFromOrderedIndex:i]];
        [button addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.rippleBeyondBounds = YES;
        button.tapCircleDiameter = MAX(button.frame.size.width, button.frame.size.height) * 1.3;
        button.rippleFromTapLocation = NO;
        button.cornerRadius = button.frame.size.width / 2;
        [container addSubview:button];
        [self.view addSubview:container];
    }
}

- (void)setUpButtonColors
{
    for(int i = 0; i < [Constants getListOfRouteNames].count; i++)
    {
        NSString *routeForButton = [Constants getRoutesFromOrderedIndex:i];
        UIView *view = self.routeButtonContainers[i];
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        NSString *yesNo = self.polylinesShowing[(int)[self.routeButtonContainers indexOfObject:view]];
        
        if([yesNo isEqualToString:@"Yes"])
        {
            button.backgroundColor = [Constants getRouteColorForRoute:routeForButton];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
