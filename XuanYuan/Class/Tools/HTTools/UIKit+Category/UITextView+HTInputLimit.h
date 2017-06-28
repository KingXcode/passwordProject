//
//  UITextView+HTInputLimit.h
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (HTInputLimit)

@property (assign, nonatomic)  NSInteger ht_maxLength;//if <=0, no limit

@end
