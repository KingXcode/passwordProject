//
//  HTTools+HTRegularExpression.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+HTRegularExpression.h"

@implementation HTTools (HTRegularExpression)

#pragma mark  ***** 验证字符串 format是正则表达式
+(BOOL)ht_IsVerifyString:(NSString *)string predicateWithFormat:(NSString *)format
{
    if ([self ht_isBlankString:format]) {
        return NO;
    }
    NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",format];
    if ([check evaluateWithObject:string]) {
        return YES;
    }
    return NO;
    
}


#pragma mark  ***** 验证输入是否字母、数字与_两种组合 且6-20位
+(BOOL)ht_IsPasswordCombination:(NSString *)passWord
{
    NSString *checkRex = @"^(?![0-9]+$)(?![A-Za-z]+$)(?![_]+$)[A-Za-z0-9_]{6,20}$";
    
    NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",checkRex];
    
    if ([check evaluateWithObject:passWord]) {
        return YES;
    }
    
    return NO;
}

#pragma mark  ***** 验证输入的是否是URL地址
+ (BOOL)ht_IsUrl:(NSString *)urlStr
{
    //    NSString* verifyRules=@"^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    //    NSPredicate *verifyRulesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRules];
    //    return [verifyRulesPre evaluateWithObject:urlStr];
    
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

#pragma mark  ***** 验证输入的是否是中文
+ (BOOL)ht_IsChinese:(NSString *)chineseStr
{
    NSString *pattern = @"[\u4e00-\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:chineseStr options:0 range:NSMakeRange(0, chineseStr.length)];
    return results.count > 0;
}


#pragma mark  ***** 昵称验证
+ (BOOL)ht_IsValidateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

#pragma mark  ***** 邮政编码验证
+ (BOOL)ht_IsValidPostalcode:(NSString *)postalcode
{
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *postalcodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postalRegex];
    
    return [postalcodePredicate evaluateWithObject:postalcode];
}

#pragma mark  ***** Mac地址有效性验证
+ (BOOL)ht_IsMacAddress:(NSString *)macAddress
{
    NSString *macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    NSPredicate *macAddressPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",macAddRegex];
    
    return [macAddressPredicate evaluateWithObject:macAddress];
}

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
#pragma mark  ***** 银行卡号有效性问题Luhn算法
+ (BOOL)ht_IsBankCardlNumCheck:(NSString *)bankCardlNum
{
    NSString *lastNum = [[bankCardlNum substringFromIndex:(bankCardlNum.length-1)] copy];//取出最后一位
    NSString *forwardNum = [[bankCardlNum substringToIndex:(bankCardlNum.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++)
    {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--)
    {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++)
    {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2)
        {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }
        else
        {//奇数位
            if (num * 2 < 9)
            {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }
            else
            {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

#pragma mark ***** 判断字符串是否是字母或数字
+ (BOOL)ht_IsLetterOrNumberString:(NSString *)string
{
    NSString *letterOrNumberRegex = @"[A-Z0-9a-z]+";
    NSPredicate *letterOrNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterOrNumberRegex];
    return [letterOrNumberTest evaluateWithObject:string];
}


#pragma mark ***** textField:shouldChangeCharactersInRange:replacementString:  该方法中调用这个方法
/**
 
 sample code...
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 return [HTTools ht_verifyTextField:textField replacementString:string MaxAmount:999999999];
 }
 */
+(BOOL)ht_verifyTextField:(UITextField *)textField replacementString:(NSString *)string MaxAmount:(NSInteger)kMaxAmount
{
    //保留后两位
    NSString *amountText = textField.text;
    NSString *regStr = @"^([1-9][\\d]{0,100}|0)(\\.[\\d]{0,1})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regStr];
    BOOL match = [predicate evaluateWithObject:amountText];
    
    if ([string isEqualToString:@""]) return YES;  // 始终允许用户删除
    
    NSString *tmpStr = [amountText stringByAppendingString:string];
    
    NSString *numStr = [[tmpStr componentsSeparatedByString:@"."] firstObject];
    
    NSInteger amount = [numStr integerValue];
    
    if (([amountText integerValue] == kMaxAmount) && (![string isEqualToString:@""])) return NO;
    
    BOOL result = [amountText isEqualToString:@""] ? YES : (match && ((amount <= kMaxAmount) || [string isEqualToString:@"."]));
    
    return result;
}
@end
