//
//  UIButton+HTImagePosition.h
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTImagePosition) {
    HTImagePositionLeft = 0,              //图片在左，文字在右，默认
    HTImagePositionRight = 1,             //图片在右，文字在左
    HTImagePositionTop = 2,               //图片在上，文字在下
    HTImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (HTImagePosition)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)ht_setImagePosition:(HTImagePosition)postion spacing:(CGFloat)spacing;

@end


@interface UIButton (HTEnlargeEdge)
/**
 *  修改Btn的点击范围
 */
- (void)ht_setEnlargeEdge:(CGFloat) size;
/**
 *  修改Btn的点击范围
 */
- (void)ht_setEnlargeEdgeWithOffSet:(UIEdgeInsets)offset;

@end
