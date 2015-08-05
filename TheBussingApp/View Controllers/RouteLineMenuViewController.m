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


@end

@implementation RouteLineMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *oneContainer = (UIView*)self.routeButtonContainers[0];
    BFPaperButton *one = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [one setTitle:@"1" forState:UIControlStateNormal];
    [one setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [one setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    one.backgroundColor = [UIColor lightGrayColor];
    one.tapCircleColor = [Constants getRouteColorForRouteNumber:[one.titleLabel.text intValue]];
    [one addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    one.rippleBeyondBounds = YES;
    one.tapCircleDiameter = MAX(one.frame.size.width, one.frame.size.height) * 1.3;
    one.rippleFromTapLocation = NO;
    one.cornerRadius = one.frame.size.width / 2;
    [oneContainer addSubview:one];
    [self.view addSubview:oneContainer];
    
    UIView *twoContainer = (UIView*)self.routeButtonContainers[1];
    BFPaperButton *two = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [two setTitle:@"2" forState:UIControlStateNormal];
    [two setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [two setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    two.backgroundColor = [UIColor lightGrayColor];
    two.tapCircleColor = [Constants getRouteColorForRouteNumber:[two.titleLabel.text intValue]];
    [two addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    two.rippleBeyondBounds = YES;
    two.tapCircleDiameter = MAX(two.frame.size.width, two.frame.size.height) * 1.3;
    two.rippleFromTapLocation = NO;
    two.cornerRadius = two.frame.size.width / 2;
    [twoContainer addSubview:two];
    [self.view addSubview:twoContainer];
    
    UIView *threeContainer = (UIView*)self.routeButtonContainers[2];
    BFPaperButton *three = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [three setTitle:@"3" forState:UIControlStateNormal];
    [three setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [three setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    three.backgroundColor = [UIColor lightGrayColor];
    three.tapCircleColor = [Constants getRouteColorForRouteNumber:[three.titleLabel.text intValue]];
    [three addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    three.rippleBeyondBounds = YES;
    three.tapCircleDiameter = MAX(three.frame.size.width, three.frame.size.height) * 1.3;
    three.rippleFromTapLocation = NO;
    three.cornerRadius = three.frame.size.width / 2;
    [threeContainer addSubview:three];
    [self.view addSubview:threeContainer];
    
    UIView *fourContainer = (UIView*)self.routeButtonContainers[3];
    BFPaperButton *four = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [four setTitle:@"4" forState:UIControlStateNormal];
    [four setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [four setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    four.backgroundColor = [UIColor lightGrayColor];
    four.tapCircleColor = [Constants getRouteColorForRouteNumber:[four.titleLabel.text intValue]];
    [four addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    four.rippleBeyondBounds = YES;
    four.tapCircleDiameter = MAX(four.frame.size.width, four.frame.size.height) * 1.3;
    four.rippleFromTapLocation = NO;
    four.cornerRadius = four.frame.size.width / 2;
    [fourContainer addSubview:four];
    [self.view addSubview:fourContainer];
    
    UIView *fiveContainer = (UIView*)self.routeButtonContainers[4];
    BFPaperButton *five = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [five setTitle:@"5" forState:UIControlStateNormal];
    [five setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [five setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    five.backgroundColor = [UIColor lightGrayColor];
    five.tapCircleColor = [Constants getRouteColorForRouteNumber:[five.titleLabel.text intValue]];
    [five addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    five.rippleBeyondBounds = YES;
    five.tapCircleDiameter = MAX(five.frame.size.width, five.frame.size.height) * 1.3;
    five.rippleFromTapLocation = NO;
    five.cornerRadius = five.frame.size.width / 2;
    [fiveContainer addSubview:five];
    [self.view addSubview:fiveContainer];
    
    UIView *sixContainer = (UIView*)self.routeButtonContainers[5];
    BFPaperButton *six = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [six setTitle:@"7" forState:UIControlStateNormal];
    [six setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [six setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    six.backgroundColor = [UIColor lightGrayColor];
    six.tapCircleColor = [Constants getRouteColorForRouteNumber:[six.titleLabel.text intValue]];
    [six addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    six.rippleBeyondBounds = YES;
    six.tapCircleDiameter = MAX(six.frame.size.width, six.frame.size.height) * 1.3;
    six.rippleFromTapLocation = NO;
    six.cornerRadius = six.frame.size.width / 2;
    [sixContainer addSubview:six];
    [self.view addSubview:sixContainer];
    
    UIView *sevenContainer = (UIView*)self.routeButtonContainers[6];
    BFPaperButton *seven = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [seven setTitle:@"20" forState:UIControlStateNormal];
    [seven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seven setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    seven.backgroundColor = [UIColor lightGrayColor];
    seven.tapCircleColor = [Constants getRouteColorForRouteNumber:[seven.titleLabel.text intValue]];
    [seven addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    seven.rippleBeyondBounds = YES;
    seven.tapCircleDiameter = MAX(seven.frame.size.width, seven.frame.size.height) * 1.3;
    seven.rippleFromTapLocation = NO;
    seven.cornerRadius = seven.frame.size.width / 2;
    [sevenContainer addSubview:seven];
    [self.view addSubview:sevenContainer];
    
    UIView *eightContainer = (UIView*)self.routeButtonContainers[7];
    BFPaperButton *eight = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [eight setTitle:@"27" forState:UIControlStateNormal];
    [eight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [eight setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    eight.backgroundColor = [UIColor lightGrayColor];
    eight.tapCircleColor = [Constants getRouteColorForRouteNumber:[eight.titleLabel.text intValue]];
    [eight addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    eight.rippleBeyondBounds = YES;
    eight.tapCircleDiameter = MAX(eight.frame.size.width, eight.frame.size.height) * 1.3;
    eight.rippleFromTapLocation = NO;
    eight.cornerRadius = eight.frame.size.width / 2;
    [eightContainer addSubview:eight];
    [self.view addSubview:eightContainer];
    
    UIView *nineContainer = (UIView*)self.routeButtonContainers[8];
    BFPaperButton *nine = [[BFPaperButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) raised:NO];
    [nine setTitle:@"86" forState:UIControlStateNormal];
    [nine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nine setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    nine.backgroundColor = [UIColor lightGrayColor];
    nine.tapCircleColor = [Constants getRouteColorForRouteNumber:[nine.titleLabel.text intValue]];
    nine.rippleBeyondBounds = YES;
    nine.tapCircleDiameter = MAX(nine.frame.size.width, nine.frame.size.height) * 1.3;
    nine.rippleFromTapLocation = NO;
    nine.cornerRadius = nine.frame.size.width / 2;
    [nineContainer addSubview:nine];
    [nine addTarget:self action:@selector(routeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nineContainer];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.backgroundBlur = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.backgroundBlur.frame = self.view.bounds;
    
    [self.view insertSubview:self.backgroundBlur atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpButtons];
    NSLog(@"%@", self.polylinesShowing);
}

- (void)routeButtonPressed:(BFPaperButton*)button
{
    if(button.backgroundColor != [UIColor lightGrayColor])
    {
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self changePolylineOnDelegate:NO atIndex:[Constants getRouteNumberInOrder:[button.titleLabel.text intValue]]];
    } else
    {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [Constants getRouteColorForRouteNumber:[button.titleLabel.text intValue]];
        [self changePolylineOnDelegate:YES atIndex:[Constants getRouteNumberInOrder:[button.titleLabel.text intValue]]];
    }
}

- (IBAction)xButtonTouched:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enableAllPressed:(UIButton *)sender
{
    for(UIView *view in self.routeButtonContainers)
    {
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        if(button.backgroundColor == [UIColor lightGrayColor])
        {
            button.backgroundColor = [Constants getRouteColorForRouteNumber:[button.titleLabel.text intValue]];
        }
        [self changePolylineOnDelegate:YES atIndex:(int)[self.routeButtonContainers indexOfObject:view]];
    }
}

- (IBAction)disableAll:(UIButton *)sender
{
    for(UIView *view in self.routeButtonContainers)
    {
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        if(button.backgroundColor != [UIColor lightGrayColor])
        {
            button.backgroundColor = [UIColor lightGrayColor];
        }
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

- (void)setUpButtons
{
    for(UIView *view in self.routeButtonContainers)
    {
        BFPaperButton *button = (BFPaperButton*)view.subviews[0];
        NSString *yesNo = self.polylinesShowing[(int)[self.routeButtonContainers indexOfObject:view]];
        
        if([yesNo isEqualToString:@"Yes"])
        {
            button.backgroundColor = [Constants getRouteColorForRouteNumber:[button.titleLabel.text intValue]];
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
