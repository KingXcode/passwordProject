//
//  HTTools+FileManager.h
//  XuanYuan
//
//  Created by King on 2017/5/6.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

/*
    所有的操作都在主线程中,如果需要,请自主在子线程中做操作
 */
@interface HTTools (FileManager)
/**
 @param path 文件是否存在
 */
+(BOOL)ht_file_existsAtPath:(NSString *)path;


/**
 @param path 移除文件
 */
+(BOOL)ht_file_removeFilePath:(NSString *)path error:(NSError **)error;


/**
 创建Documents文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToDocuments:(NSString *)path error:(NSError **)error;



/**
 创建Library文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToLibrary:(NSString *)path error:(NSError **)error;



/**
 创建LibraryCache文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToLibraryCache:(NSString *)path error:(NSError **)error;


/**
 创建Tmp文件夹
 
 @param path 路径不包括主路径部分
 @return 返回创建是否成功
 */
+(BOOL)ht_file_createFilePathToTmp:(NSString *)path error:(NSError **)error;


#pragma -mark-  最好是使用后面两个CachePath方法
/********************************************************************************************************/
/**
 将二进制文件直接写入对应的路径
 如果路径不存在 会自动创建路径
 在指定的目录下创建文件，
 如果该文件名（文件名包括了后缀在内，比如test1和test1.html是两个文件）存在，则将这个文件删除，然后再创建；
 如果文件名不存在，则直接创建
 */
+(BOOL)ht_file_createFileAtPath:(NSString *)path contents:(NSData *)data;
/**
 从对应路径获取二进制文件
 
 @param path 路径
 @return 如果路径为空  返回nil
 */
+(NSData *)ht_file_readContentsAtPath:(NSString *)path;




/**
 将二进制文件直接写入LibraryCache路径
 如果路径不存在 会自动创建路径
 （文件名包括了后缀在内，比如test1和test1.html是两个文件）存在，则将这个文件删除，然后再创建；
 */
+(BOOL)ht_file_createFileAtToLibraryCachePath:(NSString *)path contents:(NSData *)data;
/**
 从LibraryCache路径获取二进制文件
 （文件名包括了后缀在内，比如test1和test1.html是两个文件）存在，则将这个文件删除，然后再创建；
 @param path 路径
 @return 如果路径为空  返回nil
 */
+(NSData *)ht_file_readContentsAtFromLibraryCachePath:(NSString *)path;

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
+(BOOL)ht_file_movePath:(NSString *)path toPath:(NSString *)toPath  error:(NSError **)error;

/**
 path文件必须存在，toPath路径所在的中间路径也必须存在，
 创建toPath，将内容拷贝过去，同时保留path文件
 
 @param path 原路径
 @param toPath 复制的新路径
 @param error 错误
 @return 是否复制成功
 */
+(BOOL)ht_file_copyPath:(NSString *)path toPath:(NSString *)toPath  error:(NSError **)error;





@end
