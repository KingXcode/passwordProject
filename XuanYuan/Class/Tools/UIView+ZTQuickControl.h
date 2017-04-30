//
//  UIView+ZTQuickControl.h
//  BlockUseDemo
//
//  Created by quiet on 15/7/15.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZTButton.h"

@interface UIView (ZTQuickControl)

/**
 直接添加文字按钮到当前View (系统按钮、字号14、黑色)

 @param frame 位置
 @param title 标题
 @param action 点击事件
 @return 按钮
 */
-(UIButton *)addTextButtonWithFrame:(CGRect)frame
                           title:(NSString *)title
                          action:(void(^)(ZTButton *button))action;

/**
 创建文字按钮 (系统按钮、字号14、黑色)
 
 @param frame 位置
 @param title 标题
 @param action 点击事件
 @return 按钮
 */
+(UIButton *)textButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                               action:(void(^)(ZTButton *button))action;

/**
 直接添加图片按钮到当前View
 
 @param frame 位置
 @param title 标题
 @param action 点击事件
 @return 按钮
 */
-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                           title:(NSString *)title
                         image:(NSString *)image
                          action:(void(^)(ZTButton *button))action;

/**
 创建图片按钮
 
 @param frame 位置
 @param title 标题
 @param action 点击事件
 @return 按钮
 */
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                               image:(NSString *)image
                              action:(void(^)(ZTButton *button))action;

/**
 添加Label到当前View

 @param frame 位置
 @param title 标题
 @param font 字体
 @param color 颜色
 @return Label
 */
-(UILabel *)addLabelWithFrame:(CGRect)frame
                        title:(NSString *)title
                         font:(UIFont *)font
                    textColor:(UIColor *)color;

/**
 添加ImageView到当前View

 @param frame 位置
 @param image 图片
 @return ImageView
 */
-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                        image:(NSString *)image;


/**
 添加TextField到当前View

 @param frame 位置
 @param style 风格
 @param delegate 代理
 @return TextField
 */
-(UITextField *)addTextFieldWithFrame:(CGRect)frame
                                style:(UITextBorderStyle)style
                             delegate:(id)delegate;
@end
