//
//  HTDatePickerCell.h
//  XuanYuan
//
//  Created by King on 2017/5/13.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDatePickerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic,assign)BOOL enable;
-(void)setEnable:(BOOL)enable;
@end
