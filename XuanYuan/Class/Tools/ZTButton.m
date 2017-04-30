//
//  ZTButton.m
//  BlockUseDemo
//
//  Created by quiet on 15/7/15.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "ZTButton.h"

@implementation ZTButton

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)btnClick:(ZTButton *)button
{
    //作用: 原来被点击执行target-action对应的方法
    //现在: 判断action是否已经设置block, 如果被设置, 执行block
    if(self.action)
    {
        self.action(button);
    }
}

@end
