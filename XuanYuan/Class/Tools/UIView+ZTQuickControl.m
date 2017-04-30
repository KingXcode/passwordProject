//
//  UIView+ZTQuickControl.m
//  BlockUseDemo
//
//  Created by quiet on 15/7/15.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "UIView+ZTQuickControl.h"
#import "MyColor.h"

@implementation UIView (ZTQuickControl)
-(UIButton *)addTextButtonWithFrame:(CGRect)frame
                           title:(NSString *)title
                          action:(void(^)(ZTButton *button))action
{
    ZTButton *button = [ZTButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[MyColor setBlackTextColor] forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}

+(UIButton *)textButtonWithFrame:(CGRect)frame
                           title:(NSString *)title
                          action:(void(^)(ZTButton *button))action
{
    ZTButton *button = [ZTButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[MyColor setBlackTextColor] forState:UIControlStateNormal];
    button.action = action;
    return button;
}

//创建图片按钮
-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                               image:(NSString *)image
                              action:(void(^)(ZTButton *button))action
{
    ZTButton *button = [ZTButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:[MyColor setBlackTextColor] forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}

//获取图片按钮(不直接添加到view)
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                            title:(NSString *)title
                            image:(NSString *)image
                           action:(void(^)(ZTButton *button))action
{
    ZTButton *button = [ZTButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:[MyColor setBlackTextColor] forState:UIControlStateNormal];
    button.action = action;
    return button;
}

//创建label
-(UILabel *)addLabelWithFrame:(CGRect)frame
                        title:(NSString *)title
                         font:(UIFont *)font
                        textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    [self addSubview:label];
    return label;
}

//创建imageView
-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                                image:(NSString *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:image];
    [self addSubview:imageView];
    return imageView;
}
//创建textfiled
-(UITextField *)addTextFieldWithFrame:(CGRect)frame
                                style:(UITextBorderStyle)style
                             delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = style;
    textField.delegate = delegate;
    [self addSubview:textField];
    return textField;
}

@end
