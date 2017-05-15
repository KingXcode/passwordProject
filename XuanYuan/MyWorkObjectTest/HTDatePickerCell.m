//
//  HTDatePickerCell.m
//  XuanYuan
//
//  Created by King on 2017/5/13.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTDatePickerCell.h"

@interface HTDatePickerCell()


@end

@implementation HTDatePickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dateButton.userInteractionEnabled = NO;
    self.dateButton.backgroundColor = [UIColor clearColor];
}



-(void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.dateButton.enabled = enable;
    if (enable) {
        [self.dateButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];

    }else
    {
        [self.dateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }
}




@end
