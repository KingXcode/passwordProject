//
//  UIResponder+HTFirstResponder.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIResponder+HTFirstResponder.h"

static __weak id ht_currentFirstResponder;

@implementation UIResponder (HTFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)ht_currentFirstResponder {
    ht_currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(ht_findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return ht_currentFirstResponder;
}

- (void)ht_findCurrentFirstResponder:(id)sender {
    ht_currentFirstResponder = self;
}

@end
