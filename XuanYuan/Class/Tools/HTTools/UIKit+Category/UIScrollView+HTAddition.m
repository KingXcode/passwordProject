//
//  UIScrollView+HTAddition.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIScrollView+HTAddition.h"

@implementation UIScrollView (HTAddition)

- (CGFloat)ht_contentWidth {
    return self.contentSize.width;
}
- (void)setHt_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)ht_contentHeight {
    return self.contentSize.height;
}
- (void)setHt_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)ht_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setHt_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)ht_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setHt_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)ht_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)ht_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)ht_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)ht_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (HTScrollDirection)ht_ScrollDirection
{
    HTScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = HTScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = HTScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = HTScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = HTScrollDirectionRight;
    }
    else
    {
        direction = HTScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)ht_isScrolledToTop
{
    return self.contentOffset.y <= [self ht_topContentOffset].y;
}
- (BOOL)ht_isScrolledToBottom
{
    return self.contentOffset.y >= [self ht_bottomContentOffset].y;
}
- (BOOL)ht_isScrolledToLeft
{
    return self.contentOffset.x <= [self ht_leftContentOffset].x;
}
- (BOOL)ht_isScrolledToRight
{
    return self.contentOffset.x >= [self ht_rightContentOffset].x;
}
- (void)ht_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self ht_topContentOffset] animated:animated];
}
- (void)ht_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self ht_bottomContentOffset] animated:animated];
}
- (void)ht_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self ht_leftContentOffset] animated:animated];
}
- (void)ht_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self ht_rightContentOffset] animated:animated];
}
- (NSUInteger)ht_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)ht_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)ht_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)ht_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

@end
