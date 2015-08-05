//
//  BusRouteListViewController.h
//  KenoshaAreaTransit
//
//  BusRouteListViewController controlls the results list from the scan button
//  of the  App.  The list will display a series of table cells that show the
//  direction, the number, and the time of the route(s) that will go to that stop.
//
//  Created by Valerie Berglind on 2/22/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusListTableCell.h"
#import "DatabaseManager.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface BusRouteListViewController : UITableViewController
    <UITableViewDataSource, UITableViewDelegate>
{
    DatabaseManager *db;
}
@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSMutableArray *busListArray;
@property (strong, nonatomic) NSString *qrResult;
@property (strong, nonatomic) IBOutlet UITableView *busListTableView;


-(id)initWithValue:(NSString *)result;
@end
