//
//  ClassificationModel.m
//  XuanYuan
//
//  Created by King on 2017/4/24.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationModel.h"

@implementation ClassificationModel

//mj_totalIgnoredPropertyNames
+(NSMutableArray *)mj_totalIgnoredPropertyNames
{
    return [NSMutableArray arrayWithObjects:@"selectState",@"cellHeight", nil];
}


-(CGFloat)cellHeight
{
    if (self.selectState) {
        
        CGFloat height = 75 + self.infoPassWord.count*29;
        
        if (![HTTools ht_isBlankString:self.remarks]) {
            
            CGFloat h = [HTTools heightOfString:self.remarks font:[UIFont systemFontOfSize:15] width:IPHONE_WIDTH-16-18]+25+8;
            height += h;
            
        }
        
        return height;
    }else
    {
        return 75;
    }
}

@end
