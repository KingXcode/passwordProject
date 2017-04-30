//
//  HTAddItemsCell.h
//  XuanYuan
//
//  Created by King on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAddItemsModel.h"
@interface HTAddItemsCell : UITableViewCell

@property (nonatomic,copy) void (^didEndEditing)(NSString *str,NSInteger index,HTAddItemsModel *model);

@property (nonatomic,strong) HTAddItemsModel *model;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet HoshiTextField *textField;

@end
