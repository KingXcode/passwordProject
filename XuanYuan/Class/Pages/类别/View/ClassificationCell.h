//
//  ClassificationCell.h
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/18.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"

@interface ClassificationCell : UITableViewCell


@property (nonatomic,strong) ClassificationModel *model;

@property (nonatomic,copy) void (^longPressCell)(ClassificationModel *model,UILongPressGestureRecognizer *gesture);

@end
