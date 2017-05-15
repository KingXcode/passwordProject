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
 默认设置
 */
-(void)defaultSetting;



/**
 主色调
 */
-(void)mainRGB:(UIColor *)color;
-(UIColor *)mainRGB;


/**
 是否打开启动密码
 */
-(void)isOpenStartPassword:(BOOL)isopen;
-(BOOL)isOpenStartPassword;
-(BOOL)checkInputPassword:(NSString *)inputPassword;



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


/**
 是否允许三方键盘
 */
-(void)isAllowThirdKeyboard:(BOOL)isAllow;
-(BOOL)isAllowThirdKeyboard;



/**
 打开源代码页面
 */
-(void)openSourceCodeWebView;
-(void)openBlogWebView;


/**
 能否发送邮件
 */
-(BOOL)canSendEmail;
/**
 发送邮件
 
 @param subject 设置邮件主题
 @param recipients 设置收件人
 @param emailContent 邮件内容
 */
- (void)sendEmailActionWithSubject:(NSString *)subject
                        Recipients:(NSString *)recipients
                       MessageBody:(NSString *)emailContent;



/**
 是否允许入侵记录
 */
-(void)isAllowInvadeRecord:(BOOL)isAllow;
-(BOOL)isAllowInvadeRecord;



/**
 启用调试模式
 */
-(void)isDebug:(BOOL)isDebug;
-(BOOL)isDebug;



@end
