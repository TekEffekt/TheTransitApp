//
//  IncomingBusCell.h
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 3/28/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomingBusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *routeBanner;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;

@property(nonatomic) NSString* route;

@end
