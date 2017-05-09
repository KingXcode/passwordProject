//
//  HTCheckPasswordErrorModel.h
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTCheckPasswordErrorModel : NSObject

@property (nonatomic,copy) NSString * ID;           //记录ID   正常不需要设置这个值
@property (nonatomic,copy) NSString *dateString;

@property (nonatomic,assign) NSInteger errorCount;
@property (nonatomic,copy) NSString *imageString;
@property (nonatomic,copy) NSString *location;



+(UIImage *)stringToImage:(NSString *)imageString;
+(NSString *)imageToString:(UIImage *)image;

/**
 将自身保存进入数据库
 */
-(void)saveObject;


/**
 讲数据库中的数据取出
 */
+(NSArray *)getModelArray;

@end
