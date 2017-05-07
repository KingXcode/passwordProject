//
//  HTCheckPasswordErrorModel.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTCheckPasswordErrorModel.h"
#import "HTDataBaseManager.h"

@implementation HTCheckPasswordErrorModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dataStr = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSince1970*1000];
        _ID = [HTTools ht_DateWithLongTime:dataStr dateFormat:@"yyyyMMddHHmmss"];
        
        _dateString = [HTTools ht_DateWithLongTime:dataStr dateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        
    }
    return self;
}


-(void)saveObject
{
    if ([HTTools ht_isBlankString:self.imageString]) {
        return;
    }

    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager updataErrorPasswordWarningListByModel:self];
}

+(UIImage *)stringToImage:(NSString *)imageString
{
    if ([HTTools ht_isBlankString:imageString]) {
        return nil;
    }
    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:imageString options:0];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

+(NSString *)imageToString:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    return encodedImageStr;
}


+(NSArray *)getModelArray
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    NSArray *list = [manager getErrorPasswordWarningList];
    
    NSArray *newArray = [[self class] mj_objectArrayWithKeyValuesArray:list];
    
    newArray = [HTTools ht_SortModelArrar:newArray info:@{@"ID.integerValue":[NSNumber numberWithBool:NO]}];
    
    return newArray;
}

@end
