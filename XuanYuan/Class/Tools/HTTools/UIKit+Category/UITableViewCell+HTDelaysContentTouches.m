//
//  UITableViewCell+HTDelaysContentTouches.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UITableViewCell+HTDelaysContentTouches.h"

@implementation UITableViewCell (HTDelaysContentTouches)

- (UIScrollView*) ht_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setHt_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"ht_delaysContentTouches"];
    
    [[self ht_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"ht_delaysContentTouches"];
}

- (BOOL) ht_delaysContentTouches
{
    return [[self ht_scrollView] delaysContentTouches];
}


@end
