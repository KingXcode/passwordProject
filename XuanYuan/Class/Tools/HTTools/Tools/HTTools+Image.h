//
//  HTTools+Image.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (Image)
/**
 根据色值返回image
 */
+ (UIImage *)ht_createImageWithColor: (UIColor *) color;
/*
 根据传入的size讲image的尺寸重置  有一定的压缩能力
 */
+(UIImage *)ht_returnImage:(UIImage *)image BySize:(CGSize)size;
/**
 截图
 */
+(UIImage *) ht_captureScreen;
+(UIImage *) convertViewToImage:(UIView*)v;
/**
 截图并保存相册
 */
+(void)saveScreenshotToPhotosAlbum:(UIView *)view;
/**
 高斯模糊
 */
+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame;
+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame andStyle:(UIBlurEffectStyle)style;
/**
 高斯模糊的主界面截屏
 */
+(UIImageView *)gaussianBlurWithMainRootView;

@end
