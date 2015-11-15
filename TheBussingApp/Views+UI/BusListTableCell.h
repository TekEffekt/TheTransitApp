//
//  BusListTableCell.h
//  KenoshaAreaTransit
//
//  BusListTableCell draws and handles the scan results as individual table
//  cells, which will be displayed in the BusRouteListViewController file.
//
//  Created by Valerie Berglind on 2/22/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusRouteListViewController.h"

@interface BusListTableCell : UITableViewCell {
    UIButton *BusListCell;
}

//@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *num;
@property (strong, nonatomic) IBOutlet UILabel *dir;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property(nonatomic) NSString* route;
@property (weak, nonatomic) IBOutlet UILabel *milesLabel;

@end
