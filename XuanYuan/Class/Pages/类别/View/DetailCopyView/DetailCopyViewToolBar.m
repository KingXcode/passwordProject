//
//  DetailCopyViewToolBar.m
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "DetailCopyViewToolBar.h"

@interface DetailCopyViewToolBar()


@end

@implementation DetailCopyViewToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)didMoveToSuperview
{

}


-(void)configUI
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.layer.borderWidth = 1;
    leftButton.layer.borderColor = MainTextColor.CGColor;
    leftButton.layer.cornerRadius = 5;
    leftButton.layer.masksToBounds = YES;
    [leftButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [leftButton setImage:[UIImage imageNamed:@"箭头左"] forState:UIControlStateNormal];
    [self addSubview:leftButton];
    _leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor = MainTextColor.CGColor;
    rightButton.layer.cornerRadius = 5;
    rightButton.layer.masksToBounds = YES;
    [rightButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [rightButton setImage:[UIImage imageNamed:@"箭头右"] forState:UIControlStateNormal];
    [self addSubview:rightButton];
    _rightButton = rightButton;
    
    
    UIButton *newlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newlineButton.layer.borderWidth = 1;
    newlineButton.layer.borderColor = MainTextColor.CGColor;
    newlineButton.layer.cornerRadius = 5;
    newlineButton.layer.masksToBounds = YES;
    [newlineButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [newlineButton setImage:[UIImage imageNamed:@"笔记换行"] forState:UIControlStateNormal];
    [self addSubview:newlineButton];
    _newlineButton = newlineButton;
    
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.layer.borderWidth = 1;
    deleteButton.layer.borderColor = MainTextColor.CGColor;
    deleteButton.layer.cornerRadius = 5;
    deleteButton.layer.masksToBounds = YES;
    [deleteButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [deleteButton setImage:[UIImage imageNamed:@"回退"] forState:UIControlStateNormal];
    [self addSubview:deleteButton];
    _deleteButton = deleteButton;
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(leftButton.mas_right).offset(8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self);


    }];
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self);

    }];
    
    [newlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.right.equalTo(deleteButton.mas_left).offset(-8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self);

    }];
    
}

@end
