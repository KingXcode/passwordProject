//
//  ClassificationCell.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/18.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationCell.h"
#import "HTTextLabel.h"

@interface ClassificationCell()
@property (weak, nonatomic) IBOutlet UIImageView *ht_typeIcon;
@property (weak, nonatomic) IBOutlet UILabel *ht_title;

@property (weak, nonatomic) IBOutlet UILabel *ht_account;
@property (weak, nonatomic) IBOutlet UIImageView *ht_accountImageView;

@property (weak, nonatomic) IBOutlet UILabel *ht_password;
@property (weak, nonatomic) IBOutlet UIImageView *ht_passwordImageView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *collectImage;



@end

@implementation ClassificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.ht_accountImageView.image  = [self.ht_accountImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.ht_passwordImageView.image = [self.ht_passwordImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.collectImage.tintColor = MainCollectColor;
    self.collectImage.image = [self.collectImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (self.longPressCell) {
        self.longPressCell(self.model,gesture);
    }
}

-(void)setModel:(ClassificationModel *)model
{
    _model = model;
    
    NSString *noteTitle;
    if (model.iconType == 1000) {
        self.ht_account.hidden = YES;
        self.ht_accountImageView.hidden = YES;
        
        self.ht_password.hidden = YES;
        self.ht_passwordImageView.hidden = YES;
        
        noteTitle = model.account;
        
    }else
    {
        self.ht_account.hidden = NO;
        self.ht_accountImageView.hidden = NO;
        
        self.ht_password.hidden = NO;
        self.ht_passwordImageView.hidden = NO;
        
        noteTitle = @"备注:";

    }
    
    
    self.ht_typeIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",(long)_model.iconType]];
    self.ht_title.text   = [NSString stringWithFormat:@"%@",_model.accountTitle];
    self.ht_account.text = [NSString stringWithFormat:@"%@",model.account];
    self.ht_password.text = [NSString stringWithFormat:@"●●●●●●"];
    
    if (model.isCollect) {
        self.collectImage.hidden = NO;
    }else
    {
        self.collectImage.hidden = YES;
    }
    
    for (UIView *view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!model.selectState) {
        return;
    }
    
    self.ht_password.text = [NSString stringWithFormat:@"%@",model.passWord];

    
    CGFloat w = IPHONE_WIDTH-16-18;
    CGFloat h = 21;
    CGFloat x = 4;

    CGFloat flagY = 0;
    
    for (int i = 0; i<model.infoPassWord.count; i++) {
        infoPassModel *infoModel = model.infoPassWord[i];
        
        CGFloat y = 8+i*(h+8);

        HTTextLabel *label = [[HTTextLabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        
        label.titleLabel.text = [NSString stringWithFormat:@"%@:",infoModel.info_pass_Text];
        label.subTitleLabel.text = [NSString stringWithFormat:@"%@",infoModel.info_password];
        [self.bgView addSubview:label];
        
        flagY = CGRectGetMaxY(label.frame)+4;
    }

    if (![HTTools ht_isBlankString:model.remarks]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, flagY, w, h)];
        label.text = noteTitle;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = MainTextColor;
        label.font = [UIFont boldSystemFontOfSize:15];
        [self.bgView addSubview:label];
        
        flagY = CGRectGetMaxY(label.frame)+4;
        
        UILabel *remarks = [[UILabel alloc]initWithFrame:CGRectMake(x, flagY, w, 0)];
        remarks.text = model.remarks;
        remarks.numberOfLines = 0;
        remarks.textColor = MainTextColor;
        remarks.textAlignment = NSTextAlignmentLeft;
        remarks.font = [UIFont systemFontOfSize:15];
        [remarks sizeToFit];
        [self.bgView addSubview:remarks];
        
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{

    if (frame.size.width>IPHONE_WIDTH-10) {
        frame = CGRectMake(frame.origin.x + 5, frame.origin.y + 5, frame.size.width-10, frame.size.height-10);
    }else
    {
        frame = CGRectMake(frame.origin.x + 5, frame.origin.y, frame.size.width, frame.size.height);
    }
    
    [super setFrame:frame];

}

@end
