//
//  HTNotesViewController.h
//  XuanYuan
//
//  Created by King on 2017/5/11.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMainItemModel.h"


@interface HTNotesViewController : HTBaseViewController

//传入这个值就是编辑
//不传入就是新建
@property (nonatomic,strong) HTMainItemModel *model;

@end
