//
//  NSData+Encryption.h
//  XuanYuan
//
//  Created by King on 2017/4/28.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HTEncryption)


- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密


@end
