//
//  UIView+HTExtension.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HTExtension)
@property (nonatomic) CGFloat ht_x;
@property (nonatomic) CGFloat ht_y;
@property (nonatomic) CGFloat ht_width;
@property (nonatomic) CGFloat ht_height;

-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated;


-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;



-(void)ht_setCornerRadius:(CGFloat)radius;
-(void)ht_setBorderWidth:(NSInteger)width Color:(UIColor *)color;
@end
