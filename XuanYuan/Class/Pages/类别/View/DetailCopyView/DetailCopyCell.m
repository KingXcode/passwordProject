//
//  DetailCopyCell.m
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "DetailCopyCell.h"


@interface DetailCopyCell()

@property (nonatomic,weak)UILabel *label;

@end

@implementation DetailCopyCell

-(void)setText:(NSString *)text
{
    _text = text.copy;
    if (_text.length>=18) {
        
        _label.textAlignment = NSTextAlignmentLeft;

    }else
    {
        _label.textAlignment = NSTextAlignmentCenter;
    }
    self.label.text = _text;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];
        
    }
    return self;
}


-(void)configUI
{
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = MainTextColor.CGColor;
    self.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = MainTextColor;
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:label];
    _label = label;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);

        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        
    }];
    
}

@end
