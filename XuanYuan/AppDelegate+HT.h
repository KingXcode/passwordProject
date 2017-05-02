//
//  AppDelegate+HT.h
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (HT)

-(void)setShortcutIcon;

//进入添加账号界面
-(void)openAddViewController;


//进入验证界面
-(void)checkController;


/**
 启动时进入
 */
-(void)launchCheck;
@end
