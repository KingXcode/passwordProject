//
//  HTEditItemsCell.h
//  XuanYuan
//
//  Created by King on 2017/4/26.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTEditItemsModel.h"

@interface HTEditItemsCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,copy) void (^didEndEditing)(NSString *str,NSInteger index,HTEditItemsModel *model);

@property (nonatomic,strong)HTEditItemsModel * model;


@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet HoshiTextField *textField;

@end
