//
//  HTTools+Image.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+Image.h"

@implementation HTTools (Image)


+ (UIImage *)ht_createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+(UIImage *)ht_returnImage:(UIImage *)image BySize:(CGSize)size
{
    CGSize itemSize = size;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *) ht_captureScreen {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [self convertViewToImage:keyWindow];
    
}

+ (void)saveScreenshotToPhotosAlbum:(UIView *)view
{
    UIImageWriteToSavedPhotosAlbum([self convertViewToImage:view], nil, nil, nil);
}


+(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame
{
    return  [self gaussianBlurWithFrame:frame andStyle:UIBlurEffectStyleDark];
}

+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame andStyle:(UIBlurEffectStyle)style
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

+(UIImageView *)gaussianBlurWithMainRootView
{
    UIImage *image = [self ht_captureScreen];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds;
    [imageView addSubview:[self gaussianBlurWithFrame:imageView.bounds andStyle:UIBlurEffectStyleExtraLight]];
    return imageView;
}


@end
