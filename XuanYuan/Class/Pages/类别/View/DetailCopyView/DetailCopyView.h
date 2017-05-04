//
//  DetailCopyView.h
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"

@interface DetailCopyView : UIView

@property (strong,nonatomic) ClassificationModel *model;

@property (nonatomic,weak)UIButton *copybtn;
@property (nonatomic,weak)UIButton *shareBtn;

@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,weak)UIButton *closeButton;
@property (nonatomic,weak)UIButton *bigbang;
@property (nonatomic,assign) BOOL isBigBang;



/**
 设置模型数据后记得刷新视图
 */
-(void)reloadData;

@end
