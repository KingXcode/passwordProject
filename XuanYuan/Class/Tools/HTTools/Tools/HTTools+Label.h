//
//  HTTools+Label.h
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (Label)

/**
 *  改变行间距
 */
+ (void)ht_label_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)ht_label_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)ht_label_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
