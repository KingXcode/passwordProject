//
//  HTTools+String.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+String.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@implementation HTTools (String)


//移除最后无效的0 保留两位小数
+(NSString*)ht_removeFloatAllZeroKeeTwoDecimalPlaces:(NSString*)string
{
    NSString * testNumber = [NSString stringWithFormat:@"%.2f",string.floatValue];
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}
//移除无效的0 有效位有多少 保留多少位
+(NSString*)ht_removeFloatAllZero:(NSString*)string
{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

//分词 带标点
+ (NSArray *)stringTokenizerWithWord:(NSString *)word
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)word,       CFRangeMake(0, word.length),kCFStringTokenizerUnitWordBoundary,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[word substringWithRange:NSMakeRange(range.location, range.length)];
        
        if (![keyWord isEqualToString:@" "]&&![keyWord isEqualToString:@"\n"]) {
            [keyWords addObject:keyWord];
        }
        
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}

//分词 不带标点
+ (NSArray *)notDotStringTokenizerWithWord:(NSString *)word
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)word,       CFRangeMake(0, word.length),kCFStringTokenizerUnitWord,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[word substringWithRange:NSMakeRange(range.location, range.length)];
        [keyWords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    
    return [self sizeOfString:string font:font width:width].height;
}

+(CGSize)sizeOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size;
}


/**
 *  将阿拉伯数字转换为中文数字
 */

+(NSString *)ht_numberToChinese:(NSInteger)arabicNum
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:arabicNum]];
}

+(NSString *)ht_numberToChinese_low:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum == 0) {
        return @"零";
    }
    else if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}



/**
 设置行间距
 */
+(NSMutableAttributedString *)ht_stringWithString:(NSString*)string LineSpacing:(NSInteger)lineSpace
{
    NSMutableAttributedString * attributedString  = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle  = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle  range:NSMakeRange(0, [string length])];
    return  attributedString;
}

/**
 通过类对象  获取到该类的所有属性  包括私有属性
 
 @param cla 类对象
 @return 包含所有私有属性名的数组
 */
+(NSArray *)ht_logPropertyByClass:(Class) cla
{
    unsigned int count = 0;
    NSMutableArray *array = [NSMutableArray array];
    Ivar *Ivars = class_copyIvarList(cla, &count);
    
    for (int i = 0; i<count; i++) {
        
        Ivar ivar = Ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameS = [NSString stringWithUTF8String:name];
        [array addObject:nameS];
        
    }
    free(Ivars);
    return array.copy;
}

/**
 通过类对象  查看是否包含某个属性
 
 @param myClass 类对象
 @param name    类属性名
 @return  YES 包含该属性
 */
+(BOOL)ht_getVariableWithClass:(Class) myClass varName:(NSString *)name
{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}


/**
 返回字符串第一个字符
 */
+(NSString *)ht_getFirstCharacter:(NSString *)string
{
    if ([HTTools ht_isBlankString:string]) {
        return nil;
    }
    if (string.length<1) {
        return @"";
    }
    NSString *first = [string substringToIndex:1];
    
    return first;
}


/**
 返回字符串最后一个字符
 */
+(NSString *)ht_getLastCharacter:(NSString *)string
{
    if ([HTTools ht_isBlankString:string]) {
        return nil;
    }
    if (string.length<1) {
        return @"";
    }
    NSString *last = [string substringFromIndex:string.length-1];
    
    return last;
}


/**
 根据索引返回第index位的字符
 index必须小于字符串的长度  否则返回的是最后一个字符
 
 @param index 需要获取到的字符索引  从0开始
 @param string 字符串
 */
+(NSString *)ht_getCharacterByIndex:(NSInteger)index forString:(NSString *)string
{
    if ([HTTools ht_isBlankString:string]) {
        return nil;
    }
    if (string.length<1) {
        return @"";
    }
    if (string.length < index) {
        return [self ht_getLastCharacter:string];
    }
    
    NSString *first = [string substringFromIndex:index];
    
    first = [self ht_getFirstCharacter:first];
    
    return first;
}




//将十进制转化为二进制,设置返回NSString 长度
+ (NSString *)ht_decimalTOBinary:(uint16_t)tmpid backLength:(int)length
{
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }
        
        a = [b stringByAppendingString:a];
    }
    
    return a;
    
}


//将十进制转化为十六进制

+ (NSString *)ht_ToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}


//将16进制转化为二进制
+ (NSString *)ht_getBinaryByhex:(NSString *)hex
{
    NSDictionary  *hexDic = [self ht_getHexDic];
    
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        [binaryString appendString:[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
    
}

+(NSDictionary *)ht_getHexDic
{
    NSMutableDictionary *hexDic = [NSMutableDictionary dictionary];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    [hexDic setObject:@"1010" forKey:@"a"];
    [hexDic setObject:@"1011" forKey:@"b"];
    [hexDic setObject:@"1100" forKey:@"c"];
    [hexDic setObject:@"1101" forKey:@"d"];
    [hexDic setObject:@"1110" forKey:@"e"];
    [hexDic setObject:@"1111" forKey:@"f"];
    
    return hexDic.copy;
}



//获取默认表情数组
+ (NSArray *)ht_defaultEmoticons
{
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}


//判断是否有emoji
+(BOOL)ht_stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


+ (BOOL)ht_isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



//高精度计算方法
+(NSString *)ht_firstValue:(NSString *)first andLastValue:(NSString *)last andSymbol:(NSInteger)Symbol
{
    
    //安全操作
    if (!last.length) {
        last = @"0";
    }
    
    if (!first.length) {
        first = @"0";
    }
    
    //包含 + 、 - 、 * 、 / 四部分操作
    NSDecimalNumber *firstNum = [NSDecimalNumber decimalNumberWithString:first];
    NSDecimalNumber *lastNum = [NSDecimalNumber decimalNumberWithString:last];
    
    switch (Symbol) {
        case 0:
        {
            return [[firstNum decimalNumberByAdding:lastNum] stringValue];
        }
            break;
        case 1:
        {
            return [[firstNum decimalNumberByMultiplyingBy:lastNum] stringValue];
        }
            break;
        case 2:
        {
            //除法的除数不能为0
            if (lastNum.doubleValue == 0) {
                return @"ERROR";
            }
            return [[firstNum decimalNumberByDividingBy:lastNum] stringValue];
        }
            break;
        default:
        {
            return [[firstNum decimalNumberBySubtracting:lastNum] stringValue];
        }
            break;
            
    }
}


@end
