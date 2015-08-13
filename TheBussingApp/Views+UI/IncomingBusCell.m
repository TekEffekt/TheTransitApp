//
//  IncomingBusCell.m
//  KenoshaAreaTransit
//
//  Created by Kyle Zawacki on 3/28/15.
//  Copyright (c) 2015 Richard Arthur Lebbin III. All rights reserved.
//

#import "IncomingBusCell.h"
#import "Constants.h"

@implementation IncomingBusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    self.routeBanner.layer.cornerRadius = 10;
    self.routeBanner.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.routeBanner.layer.shadowOffset = CGSizeMake(2.5f, 3.5f);
    self.routeBanner.layer.shadowRadius=1.5f;
    self.routeBanner.layer.shadowOpacity = .7f;
    
    self.routeBanner.backgroundColor = [Constants getRouteColorForRouteNumber: self.routeNumber];
    self.routeLabel.textColor = [Constants getRouteColorForRouteNumber: self.routeNumber];
}

@end
