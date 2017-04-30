//
//  HTPlaceHolderView.m
//  XuanYuan
//
//  Created by King on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTPlaceHolderView.h"

@interface HTPlaceHolderView()

@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation HTPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
        self.backgroundColor = RGB(247, 247, 247);
        
    }
    return self;
}

-(void)creatUI
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageView];
    
    _imageView = imageView;
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-20);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.equalTo(imageView.mas_width);
        
    }];
    
}
-(void)setBgImage:(UIImage *)bgImage
{
    _bgImage = bgImage;
    self.imageView.image = bgImage;
}


@end
