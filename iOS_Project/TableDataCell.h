//
//  TableDataCell.h
//  iOS_Project
//
//  Created by Quyen Xuan on 1/13/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface TableDataCell : UITableViewCell
@property (strong, nonatomic) IBOutlet RateView *rate_view;
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;
@property (strong, nonatomic) IBOutlet UILabel *locationType;
@property (strong, nonatomic) IBOutlet UILabel *locationAddress;


@end
