//
//  HTEncryptionAndDecryption.m
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTEncryptionAndDecryption.h"
#import "NSData+HTEncryption.h"

NSString * const __aesKey = @"com.niesiyang";

@implementation HTEncryptionAndDecryption


+(NSString *)Encryption:(NSString *)password
{
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesData = [data AES256EncryptWithKey:__aesKey];
    NSData *base64Data = [aesData base64EncodedDataWithOptions:0];
    return  [[NSString alloc] initWithData:base64Data  encoding:NSUTF8StringEncoding];
}

+(NSString *)Decryption:(NSString *)password
{
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedData:data options:0];
    NSData *aseData = [decodeData AES256DecryptWithKey:__aesKey];
    return  [[NSString alloc] initWithData:aseData  encoding:NSUTF8StringEncoding];
}



/**
 加密 字典
 */
+(NSDictionary *)EncryptionDict:(NSDictionary *)dict
{
    NSMutableDictionary *newModelDict = [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * key, id obj, BOOL * _Nonnull stop) {
        
        NSString *newkey = [HTEncryptionAndDecryption Encryption:key];
        if ([obj isKindOfClass:[NSString class]]) {
            
            NSString *newObj = [HTEncryptionAndDecryption Encryption:obj];
            [newModelDict setObject:newObj forKey:newkey];
            
        }else if ([obj isKindOfClass:[NSNumber class]])
        {
            NSString *numobj = [NSString stringWithFormat:@"%@",obj];
            NSString *newObj = [HTEncryptionAndDecryption Encryption:numobj];
            [newModelDict setObject:newObj forKey:newkey];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            NSMutableArray *newArray = [NSMutableArray array];
            for (NSDictionary *infoDic in obj) {
                NSDictionary *newinfoDic = [self EncryptionDict:infoDic];
                [newArray addObject:newinfoDic];
            }
            [newModelDict setObject:newArray forKey:newkey];

        }
        
        
    }];
    
    return newModelDict;
}


/**
 解密 字典
 */
+(NSDictionary *)DecryptionDict:(NSDictionary *)dict
{
    NSMutableDictionary *newModelDict = [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * key, id obj, BOOL * _Nonnull stop) {
        
        NSString *newkey = [HTEncryptionAndDecryption Decryption:key];
        if ([HTTools ht_isBlankString:newkey]) {
            return ;
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            
            NSString *newObj = [HTEncryptionAndDecryption Decryption:obj];
            if (![HTTools ht_isBlankString:newObj]) {
                [newModelDict setObject:newObj forKey:newkey];
            }else
            {
                [newModelDict setObject:@"" forKey:newkey];
            }
            
        }else if ([obj isKindOfClass:[NSNumber class]])
        {
            NSString *numobj = [NSString stringWithFormat:@"%@",obj];
            NSString *newObj = [HTEncryptionAndDecryption Decryption:numobj];
            
            if (![HTTools ht_isBlankString:newObj]) {
                [newModelDict setObject:newObj forKey:newkey];
            }else
            {
                [newModelDict setObject:@"" forKey:newkey];
            }
            
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            NSMutableArray *newArray = [NSMutableArray array];
            for (NSDictionary *infoDic in obj) {
                NSDictionary *newinfoDic = [self DecryptionDict:infoDic];
                [newArray addObject:newinfoDic];
            }
            
            if (newArray != nil) {
                [newModelDict setObject:newArray forKey:newkey];
            }else
            {
                [newModelDict setObject:@[] forKey:newkey];
            }
            
        }
        
        
    }];
    
    return newModelDict;
}



@end
