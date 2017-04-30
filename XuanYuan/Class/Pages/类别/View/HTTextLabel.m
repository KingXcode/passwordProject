//
//  HTTextLabel.m
//  XuanYuan
//
//  Created by King on 2017/4/25.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTextLabel.h"
#import <Masonry.h>


@interface HTTextLabel()



@end

@implementation HTTextLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLebel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:titleLebel];
        titleLebel.textAlignment = NSTextAlignmentLeft;
        titleLebel.textColor = MainTextColor;
        titleLebel.font = [UIFont systemFontOfSize:15];
        
        UILabel *subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:subTitleLabel];
        subTitleLabel.textAlignment = NSTextAlignmentRight;
        subTitleLabel.textColor = MainTextColor;
        subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        [titleLebel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(4);
            
        }];
        
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-8);
        }];
        
        _titleLabel = titleLebel;
        _subTitleLabel = subTitleLabel;
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];//RGBA(34, 34, 34, 0.1);
        
        
    }
    return self;
}


@end
