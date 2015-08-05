//
//  NearMeTableViewController.h
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 2/15/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface NearMeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *routesTableView;
@property(strong, nonatomic) NSArray *routes;

@end
