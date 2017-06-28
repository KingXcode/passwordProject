//
//  HTTools+SandBox.m
//  XuanYuan
//
//  Created by King on 2017/5/6.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+SandBox.h"

@implementation HTTools (SandBox)
+(NSString *)ht_sandbox_getHomePath
{
    NSString *homePath = NSHomeDirectory();
    return homePath;
}

+(NSString *)ht_sandbox_getDocuments
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return docPath;
}

+(NSString *)ht_sandbox_getLibrary
{
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return libPath;
}

+(NSString *)ht_sandbox_getLibrary_Preferences
{
    NSString *preferPath = [[self ht_sandbox_getLibrary] stringByAppendingPathComponent:@"Preferences"];
    return preferPath;
}

+(NSString *)ht_sandbox_getLibrary_Cache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cachePath;
}

+(NSString *)ht_sandbox_getTmp
{
    NSString *tmpPath = NSTemporaryDirectory();
    return tmpPath;
}

@end
