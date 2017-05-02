//
//  ClassificationConfig.h
//  XuanYuan
//
//  Created by King on 2017/5/1.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "HTDataBaseManager.h"
#import "ClassificationModel.h"
#import "ClassificationCell.h"
#import "HTEditItemsViewController.h"
#import "DetailCopyViewController.h"
#import "HTNavigationController.h"

@interface ClassificationConfig : NSObject

@property (nonatomic,strong)NSMutableArray<ClassificationModel *> *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,weak)UIViewController *controller;
@property (nonatomic,strong)UIView *view;
- (instancetype)initWithController:(UIViewController *)controller;

/**
 绘制controller的View
 */
-(void)drawView;

/**
 移除controller上view的所有的子视图
 */
-(void)removeSubView;
@end
