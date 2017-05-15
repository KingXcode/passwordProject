//
//  HTDatePickerView.h
//  XuanYuan
//
//  Created by King on 2017/5/12.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDatePickerView : UIView

+ (instancetype)pickerView;


-(void)showSelectYear:(NSInteger)year AndMonth:(NSInteger)month ToView:(UIView *)superView position:(CGPoint)point;

@end
