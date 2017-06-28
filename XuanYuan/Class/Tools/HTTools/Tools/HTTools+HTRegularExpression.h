//
//  HTTools+HTRegularExpression.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (HTRegularExpression)


//***** 验证字符串 format是正则表达式
//format:请参考RegularExpressionExample.h中的内容
+(BOOL)ht_IsVerifyString:(NSString *)string predicateWithFormat:(NSString *)format;

//***** 
//***** 验证输入是否字母、数字与_两种组合 且6-20位
+(BOOL)ht_IsPasswordCombination:(NSString *)passWord;
//***** 验证输入的是否是URL地址
+ (BOOL)ht_IsUrl:(NSString *)urlStr;
//***** 验证输入的是否是中文
+ (BOOL)ht_IsChinese:(NSString *)chineseStr;
//***** 昵称验证
+ (BOOL)ht_IsValidateNickname:(NSString *)nickname;
//***** 邮政编码验证
+ (BOOL)ht_IsValidPostalcode:(NSString *)postalcode;
//***** Mac地址有效性验证
+ (BOOL)ht_IsMacAddress:(NSString *)macAddress;
//***** 银行卡号有效性问题Luhn算法
+ (BOOL)ht_IsBankCardlNumCheck:(NSString *)bankCardlNum;
//***** 判断字符串是否是字母或数字
+ (BOOL)ht_IsLetterOrNumberString:(NSString *)string;


//***** 验证输入字数 不超过kMaxAmount 最多两位小数
//***** 该方法只针对纯数字输入框 textField:shouldChangeCharactersInRange:replacementString:  该方法中调用这个方法
/**
 
 sample code...
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 return [HTTools ht_verifyTextField:textField replacementString:string MaxAmount:999999999];
 }
 */
+ (BOOL)ht_verifyTextField:(UITextField *)textField replacementString:(NSString *)string MaxAmount:(NSInteger)kMaxAmount;

@end
