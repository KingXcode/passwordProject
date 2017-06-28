//
//  UIScrollView+HTPages.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIScrollView+HTPages.h"

@implementation UIScrollView (HTPages)

- (NSInteger)ht_pages{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    return pages;
}
- (NSInteger)ht_currentPage{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    CGFloat scrollPercent = [self ht_scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages-1)*scrollPercent);
    return currentPage;
}
- (CGFloat)ht_scrollPercent{
    CGFloat width = self.contentSize.width-self.frame.size.width;
    CGFloat scrollPercent = self.contentOffset.x/width;
    return scrollPercent;
}

- (CGFloat)ht_pagesY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight/pageHeight;
}
- (CGFloat)ht_pagesX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth/pageWidth;
}
- (CGFloat)ht_currentPageY{
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}
- (CGFloat)ht_currentPageX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}
- (void)ht_setPageY:(CGFloat)page{
    [self ht_setPageY:page animated:NO];
}
- (void) ht_setPageX:(CGFloat)page{
    [self ht_setPageX:page animated:NO];
}
- (void)ht_setPageY:(CGFloat)page animated:(BOOL)animated {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = page * pageHeight;
    CGFloat offsetX = self.contentOffset.x;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset];
}
- (void)ht_setPageX:(CGFloat)page animated:(BOOL)animated{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetY = self.contentOffset.y;
    CGFloat offsetX = page * pageWidth;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset animated:animated];
}


@end
