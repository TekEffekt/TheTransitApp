//
//  IncomingBusesViewController.h
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 3/28/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomingBusesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *incomingBuses;
@property (weak, nonatomic) IBOutlet UILabel *stopBanner;
@property (strong, nonatomic) NSString *stopName;

@end
