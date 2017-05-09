//
//  HTTools+Cache.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+Cache.h"

@implementation HTTools (Cache)
#pragma mark - 计算单个文件大小
+ (CGFloat)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}


#pragma mark - 缓存大小
+ (CGFloat)loadCacheSize
{
    CGFloat cacheSize = 0;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *f in files)
    {
        NSString *path = [cachPath stringByAppendingPathComponent:f];
        cacheSize += [self fileSizeAtPath:path];
    }
    return cacheSize;
    
}

#pragma mark - 计算目录大小
+ (CGFloat)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        return folderSize;
    }
    return 0;
}

#pragma mark - 清除缓存
typedef void(^ClearCacheSuccess)(NSString *path);
typedef void(^ClearCacheError)(NSString *path,NSError *error);
//block会回调很多次 每次删除一天路径的数据回调一次,block调用很频繁
//
//回调在异步线程中,如需回到主线程,请自便
+ (void)myClearCacheActionSuccess:(ClearCacheSuccess)successBlock
                            Error:(ClearCacheError  )errorBlock
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        
        for (NSString *p in files)
        {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                if (isSuccess) {
                    successBlock(path);
                }else
                {
                    errorBlock(path,error);
                }
            }
        }
    });
    
    
}


@end
