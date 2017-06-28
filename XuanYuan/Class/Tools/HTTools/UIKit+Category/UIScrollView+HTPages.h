//
//  UIScrollView+HTPages.h
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HTPages)
- (NSInteger)ht_pages;
- (NSInteger)ht_currentPage;
- (CGFloat)ht_scrollPercent;

- (CGFloat)ht_pagesY;
- (CGFloat)ht_pagesX;
- (CGFloat)ht_currentPageY;
- (CGFloat)ht_currentPageX;
- (void)ht_setPageY:(CGFloat)page;
- (void)ht_setPageX:(CGFloat)page;
- (void)ht_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)ht_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
