//
//  HTTools+Systerm.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface HTTools (Systerm)


/**
 是否具有相册相机访问权限
 */
+(AVAuthorizationStatus)ht_authorizationStatusForVideo;
/*
 *  返回的CPU使用率
 */
+ (float)cpuUsage;
/*!
 *  跳转系统通知
 */
+ (void)gotoSystermSettings;
/*!
 *  跳转Safari浏览器
 *
 *  @param url 需要用Safari打开的url
 */
+ (void)gotoSafariBrowserWithURL:(NSString *)url;
/**
 拨打电话
 */
+ (void)ht_callPhone:(NSString *)phone;

/**
 系统版本
 */
+(NSString *)phoneVersion;
/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString*)deviceVersion;

/**
 指纹识别
 */
+(void)enableTouchIDCheck:(void(^)(BOOL success, NSError *error))reply;
+(BOOL)canOpenTouchID;
/**
 震动
 */
+(void)vibrate;
@end
