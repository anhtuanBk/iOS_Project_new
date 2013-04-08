//
//  TableDataCell.m
//  iOS_Project
//
//  Created by Quyen Xuan on 1/13/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import "TableDataCell.h"

@interface TableDataCell(){
    NSString *text;
    NSString *item;
}

@end

@implementation TableDataCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
