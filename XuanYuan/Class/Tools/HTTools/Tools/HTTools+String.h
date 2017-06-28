//
//  HTTools+String.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (String)

//移除最后无效的0 保留两位小数
+(NSString*)ht_removeFloatAllZeroKeeTwoDecimalPlaces:(NSString*)string;
//移除无效的0 有效位有多少 保留多少位
+(NSString*)ht_removeFloatAllZero:(NSString*)string;

/**
 分词
 */
+ (NSArray *)stringTokenizerWithWord:(NSString *)word;

/**
 分词 不带标点
 */
+ (NSArray *)notDotStringTokenizerWithWord:(NSString *)word;

/**
 尺寸计算
 */
+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;
+(CGSize)sizeOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;


/**
 *  将阿拉伯数字转换为中文数字
 *  下面的方法比较low
 */
+(NSString *)ht_numberToChinese:(NSInteger)arabicNum;
+(NSString *)ht_numberToChinese_low:(NSInteger)arabicNum;

/**
 设置行间距
 */
+(NSMutableAttributedString *)ht_stringWithString:(NSString*)string LineSpacing:(NSInteger)lineSpace;

/**
 通过类对象  获取到该类的所有属性  包括私有属性
 
 @param cla 类对象
 @return 包含所有私有属性名的数组
 */
+(NSArray *)ht_logPropertyByClass:(Class)cla;
/**
 通过类对象  查看是否包含某个属性
 
 @param myClass 类对象
 @param name    类属性名
 @return  YES 包含该属性
 */
+(BOOL)ht_getVariableWithClass:(Class) myClass varName:(NSString *)name;
//获取默认表情数组
+(NSArray *)ht_defaultEmoticons;
//获取字符串_字符
+(NSString *)ht_getFirstCharacter:(NSString *)string;
+(NSString *)ht_getLastCharacter:(NSString *)string;
+(NSString *)ht_getCharacterByIndex:(NSInteger)index forString:(NSString *)string;
//将十进制转化为二进制,设置返回NSString 长度
+ (NSString *)ht_decimalTOBinary:(uint16_t)tmpid backLength:(int)length;
//将十进制转化为十六进制
+ (NSString *)ht_ToHex:(uint16_t)tmpid;
//将16进制转化为二进制
+ (NSString *)ht_getBinaryByhex:(NSString *)hex;
//判断是否有emoji
+ (BOOL)ht_stringContainsEmoji:(NSString *)string;
/**
 字符串判空
 */
+ (BOOL)ht_isBlankString:(NSString *)string;

@end
