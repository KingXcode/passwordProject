//
//  UIScrollView+HTAddition.h
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTScrollDirection) {
    HTScrollDirectionUp,
    HTScrollDirectionDown,
    HTScrollDirectionLeft,
    HTScrollDirectionRight,
    HTScrollDirectionWTF
};

@interface UIScrollView (HTAddition)


@property(nonatomic) CGFloat ht_contentWidth;
@property(nonatomic) CGFloat ht_contentHeight;
@property(nonatomic) CGFloat ht_contentOffsetX;
@property(nonatomic) CGFloat ht_contentOffsetY;

- (CGPoint)ht_topContentOffset;
- (CGPoint)ht_bottomContentOffset;
- (CGPoint)ht_leftContentOffset;
- (CGPoint)ht_rightContentOffset;

- (HTScrollDirection)ht_ScrollDirection;

- (BOOL)ht_isScrolledToTop;
- (BOOL)ht_isScrolledToBottom;
- (BOOL)ht_isScrolledToLeft;
- (BOOL)ht_isScrolledToRight;
- (void)ht_scrollToTopAnimated:(BOOL)animated;
- (void)ht_scrollToBottomAnimated:(BOOL)animated;
- (void)ht_scrollToLeftAnimated:(BOOL)animated;
- (void)ht_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)ht_verticalPageIndex;
- (NSUInteger)ht_horizontalPageIndex;

- (void)ht_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)ht_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
