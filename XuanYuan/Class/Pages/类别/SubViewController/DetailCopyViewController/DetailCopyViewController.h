//
//  DetailCopyViewController.h
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"

@interface DetailCopyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *backTopView;
@property (strong,nonatomic) ClassificationModel *model;
@property (nonatomic,assign) BOOL isBigBang;
@property (assign,nonatomic) BOOL isPeek;


@end
