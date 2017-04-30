//
//  HTconfigManager.h
//  XuanYuan
//
//  Created by King on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTConfigManager : NSObject

+ (instancetype)sharedconfigManager;



/**
 清空全部数据
 */
-(void)clearAllData;


/**
 是否打开启动密码
 */
-(void)isOpenStartPassword:(BOOL)isopen;
-(BOOL)isOpenStartPassword;


/**
 设置启动密码
 */
-(void)startPassword:(NSString *)password;
-(NSString *)startPassword;


/**
 是否启动TouchID功能
 */
-(void)isOpenTouchID:(BOOL)isOpen;
-(BOOL)isOpenTouchID;
@end
