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


#import "BusListTableCell.h"
#import "QuartzCore/QuartzCore.h"
#import "Constants.h"

@implementation BusListTableCell
@synthesize dir, num;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
////        img = [[UIImageView alloc] init];
//        
//        //settings for the display of the result page
//        dir = [[UILabel alloc] init];
//        dir.font = [UIFont systemFontOfSize:17];
//        dir.textAlignment = NSTextAlignmentLeft;
//        
//        num = [[UILabel alloc] init];
//        num.font = [UIFont systemFontOfSize:25];
//        num.textColor= [UIColor whiteColor];
//        num.textAlignment = NSTextAlignmentCenter;
//        num.layer.cornerRadius = 10;
//        num.layer.shadowColor = [[UIColor blackColor] CGColor];
//        num.layer.shadowOffset = CGSizeMake(2.5f, 3.5f);
//        num.layer.shadowRadius=1.5f;
//        num.layer.shadowOpacity = .7f;

//        tim = [[UILabel alloc] init];
//        tim.font = [UIFont systemFontOfSize:17];
//        tim.textAlignment = NSTextAlignmentLeft;
//        
//        timeLeft = [[UILabel alloc] init];
//        timeLeft.font = [UIFont systemFontOfSize:17];
//        timeLeft.textAlignment = NSTextAlignmentRight;
//        timeLeft.numberOfLines = 1;
//        
//        delayTime = [[UILabel alloc] init];
//        delayTime.font = [UIFont systemFontOfSize:15];
//        delayTime.textAlignment = NSTextAlignmentRight;
//        delayTime.textColor = [UIColor redColor];
//        delayTime.numberOfLines = 1;
//        
//        [self addSubview:dir];
//        [self addSubview:num];
//        [self addSubview:tim];
//        [self addSubview:timeLeft];
//        [self addSubview:delayTime];
//        [self addSubview:arrow];
//    }
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
//    
//    //set the result page layout for the cells
//    frame = CGRectMake(100, 5, 320, 40);
//    dir.frame = frame;
//    dir.backgroundColor = [UIColor clearColor];
//    dir.font =[UIFont systemFontOfSize: 17];
//    
//    frame = CGRectMake(5, 2.5, 80, 72.5);
//    num.frame = frame;
//    num.backgroundColor = [UIColor clearColor];
//    num.layer.cornerRadius = 0;
//    num.font = [UIFont systemFontOfSize:25];
//    num.layer.masksToBounds = NO;
//
//    frame = CGRectMake(100, 30, 320, 40);
//    tim.frame = frame;
//    tim.backgroundColor = [UIColor clearColor];
//
//    frame = CGRectMake(225, 2.5, 60, 72.5);
//    timeLeft.frame = frame;
//    timeLeft.backgroundColor = [UIColor clearColor];
//    
//    frame = CGRectMake(225, 30, 60, 72.5);
//    delayTime.frame = frame;
    
    num.layer.cornerRadius = 10;
    num.layer.shadowColor = [[UIColor blackColor] CGColor];
    num.layer.shadowOffset = CGSizeMake(2.5f, 3.5f);
    num.layer.shadowRadius=1.5f;
    num.layer.shadowOpacity = .7f;
    
    num.backgroundColor = [Constants getRouteColorForRouteNumber: self.routeNumber];
    self.routeLabel.textColor = [Constants getRouteColorForRouteNumber: self.routeNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
