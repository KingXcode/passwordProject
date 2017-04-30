//
//  HTEncryptionAndDecryption.h
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEncryptionAndDecryption : NSObject

/**
 加密
 */
+(NSString *)Encryption:(NSString *)password;


/**
 解密
 */
+(NSString *)Decryption:(NSString *)password;



/**
 加密 字典
 */
+(NSDictionary *)EncryptionDict:(NSDictionary *)dict;
/**
 解密 字典
 */
+(NSDictionary *)DecryptionDict:(NSDictionary *)dict;
@end
