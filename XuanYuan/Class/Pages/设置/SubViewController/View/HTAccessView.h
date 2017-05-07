//
//  HTAccessView.h
//  XuanYuan
//
//  Created by King on 2017/5/5.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//  实在是懒得写这些界面了 设置界面全都想直接拉xib

#import <UIKit/UIKit.h>

@interface HTAccessView : UIView

+(instancetype)loadView;
@property (weak, nonatomic) IBOutlet UISwitch *mainSwitch;



@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;
@property (weak, nonatomic) IBOutlet UILabel *cameraTopIabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraBottomLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraAuthorBtn;


@property (weak, nonatomic) IBOutlet UIView *localView;
@property (weak, nonatomic) IBOutlet UIImageView *localImageView;
@property (weak, nonatomic) IBOutlet UILabel *localTopIabel;
@property (weak, nonatomic) IBOutlet UILabel *localBottomLabel;
@property (weak, nonatomic) IBOutlet UIButton *localAuthorBtn;

@end
