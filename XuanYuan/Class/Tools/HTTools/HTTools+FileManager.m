//
//  HTTools+FileManager.m
//  XuanYuan
//
//  Created by King on 2017/5/6.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+FileManager.h"

/*
 创建文件目录时 attributes 可用以下参数
 
 NSString * const NSFileType;
 NSString * const NSFileSize;
 NSString * const NSFileSystemNumber;
 NSString * const NSFileSystemFileNumber;
 NSString * const NSFileExtensionHidden;
 NSString * const NSFileHFSCreatorCode;
 NSString * const NSFileHFSTypeCode;
 NSString * const NSFileImmutable;
 NSString * const NSFileBusy;

 
 NSString * const NSFileModificationDate;
 这个键的值需要设置一个NSDate对象，表示目录的修改时间。
 
 NSString * const NSFileReferenceCount;
 这个键的值需要设置为一个表示unsigned long的NSNumber对象，表示目录的引用计数，即这个目录的硬链接数。
 
 NSString * const NSFileDeviceIdentifier;
 
 NSString * const NSFileOwnerAccountName;
 这个键的值需要设置为一个NSString对象，表示这个目录的所有者的名字。
 
 NSString * const NSFileGroupOwnerAccountName;
 这个键的值需要设置为一个NSString对象，表示这个目录的用户组的名字。
 
 NSString * const NSFilePosixPermissions;
 这个键的值需要设置为一个表示short int的NSNumber对象，表示目录的访问权限。
 
 NSString * const NSFileAppendOnly;
 这个键的值需要设置为一个表示布尔值的NSNumber对象，表示创建的目录是否是只读的。
 
 NSString * const NSFileCreationDate;
 这个键的值需要设置为一个NSDate对象，表示目录的创建时间。
 
 NSString * const NSFileOwnerAccountID;
 这个键的值需要设置为一个表示unsigned int的NSNumber对象，表示目录的所有者ID。
 
 NSString * const NSFileGroupOwnerAccountID;
 这个键的值需要设置为一个表示unsigned int的NSNumber对象，表示目录的组ID。

 */

@implementation HTTools (FileManager)


/**
  @param path 文件是否存在
 */
+(BOOL)ht_file_existsAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}



/**
 @param path 移除文件
 */
+(BOOL)ht_file_removeFilePath:(NSString *)path error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager removeItemAtPath:path error:error];
    BOOL exists = [self ht_file_existsAtPath:path];
    
    return res && !exists;
}



/**
 创建文件夹    该方法不暴露
 */
+(BOOL)ht_file_createFilePath:(NSString *)path error:(NSError **)error
{
    // 创建目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager createDirectoryAtPath:path
                      withIntermediateDirectories:YES
                                       attributes:nil
                                            error:error];
    return res;
}



/**
 创建Documents文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToDocuments:(NSString *)path error:(NSError **)error
{
    NSString *directory = [[self ht_sandbox_getDocuments] stringByAppendingPathComponent:path];
    return [self ht_file_createFilePath:directory error:error];
}


/**
 创建Library文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToLibrary:(NSString *)path error:(NSError **)error
{
    NSString *directory = [[self ht_sandbox_getLibrary] stringByAppendingPathComponent:path];
    return [self ht_file_createFilePath:directory error:error];
}

/**
 创建LibraryCache文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToLibraryCache:(NSString *)path error:(NSError **)error
{
    NSString *directory = [[self ht_sandbox_getLibrary_Cache] stringByAppendingPathComponent:path];
    return [self ht_file_createFilePath:directory error:error];
}

/**
 创建Tmp文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToTmp:(NSString *)path error:(NSError **)error
{
    NSString *directory = [[self ht_sandbox_getTmp] stringByAppendingPathComponent:path];
    return [self ht_file_createFilePath:directory error:error];
}

#pragma -mark-  最好是使用后面两个CachePath方法
/********************************************************************************************************/
/**
 将二进制文件直接写入对应的路径
 如果路径不存在 会自动创建路径
 */
+(BOOL)ht_file_createFileAtPath:(NSString *)path contents:(NSData *)data
{
    if (![self ht_file_existsAtPath:path])
    {
        BOOL res = [self ht_file_createFilePath:path error:nil];
        if (res == NO) return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createFileAtPath:path contents:data attributes:nil];
}


/**
 从对应路径获取二进制文件

 @param path 路径
 @return 如果路径为空  返回nil
 */
+(NSData *)ht_file_readContentsAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager contentsAtPath:path];
}



/**
 将二进制文件直接写入LibraryCache路径
 如果路径不存在 会自动创建路径
 */
+(BOOL)ht_file_createFileAtToLibraryCachePath:(NSString *)path contents:(NSData *)data
{
    NSString *directory = [[self ht_sandbox_getLibrary_Cache] stringByAppendingPathComponent:path];
    if (![self ht_file_existsAtPath:directory])
    {
        BOOL res = [self ht_file_createFilePathToLibraryCache:path error:nil];
        if (res == NO) return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createFileAtPath:path contents:data attributes:nil];
}


/**
 从LibraryCache路径获取二进制文件
 
 @param path 路径
 @return 如果路径为空  返回nil
 */
+(NSData *)ht_file_readContentsAtFromLibraryCachePath:(NSString *)path
{
    NSString *directory = [[self ht_sandbox_getLibrary_Cache] stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager contentsAtPath:directory];
}


/********************************************************************************************************/
#pragma -mark-



/**
 如果toPath不存在，则会创建toPath，将内容拷贝过去，然后删除path文件；
 如果toPath存在，则会报错，同样toPath的中间路径也必须存在，否则会报错

 @param path 原路径
 @param toPath 新的路径
 @param error 错误
 @return 是否移动成功
 */
+(BOOL)ht_file_movePath:(NSString *)path toPath:(NSString *)toPath  error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:path toPath:toPath error:error];
}



/**
 path文件必须存在，toPath路径所在的中间路径也必须存在，
 创建toPath，将内容拷贝过去，同时保留path文件

 @param path 原路径
 @param toPath 复制的新路径
 @param error 错误
 @return 是否复制成功
 */
+(BOOL)ht_file_copyPath:(NSString *)path toPath:(NSString *)toPath  error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager copyItemAtPath:path toPath:toPath error:error];
}



















@end
