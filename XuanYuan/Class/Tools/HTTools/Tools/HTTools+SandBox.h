//
//  HTTools+SandBox.h
//  XuanYuan
//
//  Created by King on 2017/5/6.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (SandBox)
/**
 根目录
 */
+(NSString *)ht_sandbox_getHomePath;


/**
 根目录下Documents目录
 */
+(NSString *)ht_sandbox_getDocuments;


/**
 根目录下Library目录
 
 Preferences -- 此目录是偏好设置目录  NSUserDefaults数据将会保存在这里.最好不要轻易直接操作这个目录.
 */
+(NSString *)ht_sandbox_getLibrary;
+(NSString *)ht_sandbox_getLibrary_Preferences;
+(NSString *)ht_sandbox_getLibrary_Cache;

/**
 根目录下Tmp目录
 */
+(NSString *)ht_sandbox_getTmp;
@end
