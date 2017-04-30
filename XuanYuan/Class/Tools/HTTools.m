//
//  HTTools.m
//  pangu
//
//  Created by niesiyang on 2017/2/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "HTTools.h"
#import <mach/mach.h>
#import <objc/runtime.h>

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);






@interface HTTools()
#pragma -mark- 还未开放的接口

@end


#pragma -mark-  这里是分割线--------------------
@implementation HTTools

+(NSUInteger)getRandomNumber:(NSUInteger)from to:(NSUInteger)to
{
    return (NSUInteger)(from + (arc4random() % (to - from + 1)));
}


+ (BOOL)ht_navigation:(UINavigationController *)navigation jumpToViewControllerForString:(NSString *)ClassVc
{
    for (UIViewController *temp in navigation.viewControllers) {
        if ([temp isKindOfClass:NSClassFromString(ClassVc)]) {
            [navigation popToViewController:temp animated:YES];
            return YES;
        }
    }
    return NO;
}

@end


@implementation HTTools (SafariService)


+(SFSafariViewController *)openSafariServiceWithUrl:(NSURL *)url byController:(UIViewController *)controller
{
   // [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending||[[[UIDevice currentDevice] systemVersion]isEqualToString:@"10.3.1"]
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if (version.integerValue>=10) {
        
        SFSafariViewController *vc = [[SFSafariViewController alloc]initWithURL:url];
        [controller presentViewController:vc animated:YES completion:nil];
        return vc;
    }else
    {
        [self gotoSafariBrowserWithURL:url.absoluteString];
        return nil;
    }
    
}

@end


#pragma -mark-  Image--------------------

@implementation HTTools (Image)



+ (UIImage *)ht_createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+(UIImage *)ht_returnImage:(UIImage *)image BySize:(CGSize)size
{
    CGSize itemSize = size;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




@end

#pragma -mark-  Model--------------------

@implementation HTTools (Model)



+(NSString *)ht_DataToJsonString:(id)info
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = nil;
    
    if (!jsonData)
    {
        
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}


+ (NSDictionary *)ht_dictionaryWithJsonString:(NSString *)jsonString
{
    if ([self ht_isBlankString:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

@end





#pragma -mark-  AOP--------------------
@implementation HTTools (AOP)

/*!
 *  替换两个方法
 *
 *  @param originalSelector 原始方法
 *  @param swizzledSelector 替换的方法
 */
+ (void)aop_swizzlingClass:(NSString *)className
      OriginalSelector:(SEL)originalSelector
      swizzledSelector:(SEL)swizzledSelector
{
    Class class = NSClassFromString(className);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end



#pragma -mark-  Cache--------------------

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
    float folderSize;
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





#pragma -mark-  HTRegularExpression--------------------
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





#pragma -mark-  String--------------------

@implementation HTTools (String)

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)ht_translationArabicNum:(NSInteger)arabicNum
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


@end


#pragma -mark-  Array--------------------
@implementation HTTools (Array)



/*
 *    info = @{
 *             @"":[NSNumber numberWithBool:YES],
 *              ...
 *            };
 *    info    排序模型数组的相关信息
 *            key越靠前 优先级越高
 *            key    -----  为model中可以用来排序的属性    如果key是字符串等其它类型可以使用keypath的方式,如.integerValue等形式作为该字典的key
 *            value  -----  为该属性的排序方式  yes:升序   no:降序
 *
 *    modelArray 待排序的数组 ..如果该数组内的元素是可以进行排序的,那你他妈就不要用这个方法啊,系统提供了那么多排序方法   ---  有没有感受到我深深的恶意...
 *                          ..如果该数组内的元素是可以进行排序的,这个方法也可以实现 用后面的字典 ---  @{@"self":[NSNumber numberWithBool:YES]}
 *    return  排序后的新数组
 */
+(NSArray *)ht_SortModelArrar:(NSArray *)modelArray info:(NSDictionary *)info
{
    NSMutableArray *SortDescriptorArray = [NSMutableArray array];
    NSArray *infoKeyArray = [info allKeys];
    
    for (int i = 0; i < infoKeyArray.count; i++) {
        NSString *key = infoKeyArray[i];
        NSNumber *value = [info objectForKey:key];
        NSSortDescriptor *des = [[NSSortDescriptor alloc]initWithKey:key ascending:value.boolValue];
        [SortDescriptorArray addObject:des];
    }
    
    NSArray *newA = [modelArray sortedArrayUsingDescriptors:SortDescriptorArray];
    return newA;
}




//反序数组
+(NSArray *)ht_reverseArray:(NSArray *)object
{

    NSArray *reversArray = [[object reverseObjectEnumerator] allObjects];
    return reversArray;
    
//    另一种方式
//    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[object count]];
//    // 获取NSArray的逆序枚举器
//    NSEnumerator *enumerator = [object reverseObjectEnumerator];
//    for(id element in enumerator) [arrayTemp addObject:element];
//    return arrayTemp;
    
}

//去除重复的元素
+(NSArray *)ht_removeRepeatRowsForArray:(NSArray *)object
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [object count]; i++){
        if ([categoryArray containsObject:[object objectAtIndex:i]] == NO){
            [categoryArray addObject:[object objectAtIndex:i]];
        }
    }
    return categoryArray;
}

/**
 根据modelArray中的属性 去除重复的元素
 目前我的测试中 NSString 和 int类型是没有问题的,过滤正常.
 感慨一下,系统的数组提供的过滤器,排序方式真的很强大
 
 @param object 模型数组
 @param keypath 模型数组元素中的一个属性
 @return 过滤之后的新数组
 */
+(NSArray *)ht_removeRepeatRowsForArray:(NSArray *)object WithKeypath:(NSString *)keypath
{

    NSMutableSet *seenObjects = [NSMutableSet set];
    
    NSPredicate * predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {

        id property = [obj valueForKeyPath:keypath];//元素属性
        BOOL seen = [seenObjects containsObject:property];
        if (!seen) {
            [seenObjects addObject:property];
        }
        return !seen;
        
    }];
    
    NSMutableArray *categoryArray = [NSMutableArray arrayWithArray:[object filteredArrayUsingPredicate:predicate]];
    
    return categoryArray;
}


@end





#pragma -mark-  Date--------------------

@implementation HTTools (Date)

/**
 任意进制转换十进制 index为0原字符串默认为十六进制
 
 @param str 数字字符串
 @param index 字符串原本是 几进制
 @return 转换后的十进制数
 */
+(NSNumber *)ht_strToulWithStr:(NSString *)str base:(int)index
{
    if (index<=1) {
        index = 16;
    }
    NSUInteger s =  strtoul([str UTF8String], 0, index);
    NSNumber *number = [NSNumber numberWithUnsignedInteger:s];
    return number;
}



/**
 
 @param timeStr 时间戳
 @param dateFormat the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr dateFormat:(NSString *)dateFormat{
    
    long long time = [timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([self ht_isBlankString:dateFormat]) {
        
        dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
        
    }else
    {
        dateFormatter.dateFormat = dateFormat;
    }
    
    return [dateFormatter stringFromDate:d];
}


+(NSString *)ht_DateWithLongTime:(NSString *)timeStr{
    
    return [self ht_DateWithLongTime:timeStr dateFormat:nil];
}

+(NSString *) ht_compareCurrentTimes:(NSTimeInterval)timeInterval
{
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(NSString *) ht_compareCurrentTime:(NSDate*) compareDate  // 几分钟前
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    return [self ht_compareCurrentTimes:timeInterval];
}


@end




/*!
 注意：
 最低支持iOS8
 iOS 10 系统下需要请求相关权限，iOS 10 干掉了所有系统设置的 URL Scheme，这意味着你再也不可能直接跳转到系统设置页面（比如 WiFi、蜂窝数据、定位等）。
 iOS 10 不支持,任意方法都只会跳转到设置界面
 ios 10 系统，其他权限具体设置如下：
 
 麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
 相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
 相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
 通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
 蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
 语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
 日历权限：Privacy - Calendars Usage Description 是否允许此App使用日历？
 定位权限：Privacy - Location When In Use Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
 定位权限: Privacy - Location Always Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
 

 */


#define HT_OpenUrl(urlStr) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]]

#pragma -mark-  Systerm--------------------
#pragma mark  *****
@implementation HTTools (Systerm)
+ (float)cpuUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if(kr != KERN_SUCCESS)
    {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0;
    
    basic_info = (task_basic_info_t)tinfo;
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if(kr != KERN_SUCCESS)
    {
        return -1;
    }
    if(thread_count > 0)
    {
        stat_thread += thread_count;
    }
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for(j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if(kr != KERN_SUCCESS)
        {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if(!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
        
    }
    
    return tot_cpu;
}

/*!
 *  跳转系统通知
 */
+ (void)gotoSystermSettings
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        HT_OpenUrl(UIApplicationOpenSettingsURLString);
    }
}


/*!
 *  跳转Safari浏览器
 */
+ (void)gotoSafariBrowserWithURL:(NSString *)url
{
    if(![url hasPrefix:@"http"])
    {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    
    if ([self ht_IsUrl:url])
    {
        /*! 跳转系统通知 */
//        HT_OpenUrl(url);
        NSURL *newUrl = [NSURL URLWithString:url];
        if ([[UIApplication sharedApplication]canOpenURL:newUrl]) {
            
            if ([[[UIDevice currentDevice] systemVersion] compare:@"10.0"] != NSOrderedAscending) {
                
                [[UIApplication sharedApplication]openURL:newUrl options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
                [[UIApplication sharedApplication]openURL:newUrl];
            }
        }
        
    }
    else
    {
        NSLog(@"url错误，请重新输入！");
    }
    
}

+ (void)ht_callPhone:(NSString *)phone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end






@implementation UIView (HTExtension)

-(CGFloat)ht_x
{
    CGRect frame = self.frame;
    return frame.origin.x;
}

-(void)setHt_x:(CGFloat)ht_x
{
    CGRect frame = self.frame;
    frame.origin.x = ht_x;
    self.frame = frame;
}
-(CGFloat)ht_y
{
    CGRect frame = self.frame;
    return frame.origin.y;
}
-(void)setHt_y:(CGFloat)ht_y
{
    CGRect frame = self.frame;
    frame.origin.y = ht_y;
    self.frame = frame;
}
-(CGFloat)ht_width
{
    CGRect frame = self.frame;
    return frame.size.width;
}
-(void)setHt_width:(CGFloat)ht_width
{
    CGRect frame = self.frame;
    frame.size.width = ht_width;
    self.frame = frame;
}
-(CGFloat)ht_height
{
    CGRect frame = self.frame;
    return frame.size.height;
}
-(void)setHt_height:(CGFloat)ht_height
{
    CGRect frame = self.frame;
    frame.size.height = ht_height;
    self.frame = frame;
}

/*******************************************************************************/
-(void)ht_setX:(CGFloat)ht_x animated:(BOOL)animated
{
    [self ht_setX:ht_x animated:animated completion:nil];
}
-(void)ht_setY:(CGFloat)ht_y animated:(BOOL)animated
{
    [self ht_setY:ht_y animated:animated completion:nil];
}
-(void)ht_setWidth:(CGFloat)ht_width animated:(BOOL)animated
{
    [self ht_setWidth:ht_width animated:animated completion:nil];
}
-(void)ht_setHeight:(CGFloat)ht_height animated:(BOOL)animated
{
    [self ht_setHeight:ht_height animated:animated completion:nil];
}
-(void)ht_setCenter:(CGPoint)center animated:(BOOL)animated
{
    [self ht_setCenter:center animated:animated completion:nil];
}
/*******************************************************************************/

-(void)ht_setX:(CGFloat)ht_x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        
        [UIView animateWithDuration:0.3 animations:^{[self setHt_x:ht_x];}completion:completion];

    }else
    {
        [self setHt_x:ht_x];
        completion(YES);
    }
}

-(void)ht_setY:(CGFloat)ht_y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_y:ht_y];}completion:completion];
    }else
    {
        [self setHt_y:ht_y];
        completion(YES);
    }

}

-(void)ht_setWidth:(CGFloat)ht_width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_width:ht_width];}completion:completion];
    }else
    {
        [self setHt_width:ht_width];
        completion(YES);
    }
}

-(void)ht_setHeight:(CGFloat)ht_height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_height:ht_height];}completion:completion];
    }else
    {
        [self setHt_height:ht_height];
        completion(YES);
    }
}

-(void)ht_setCenter:(CGPoint)center animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setCenter:center];}completion:completion];
    }else
    {
        [self setCenter:center];
    }
}



-(void)ht_setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;

}

-(void)ht_setBorderWidth:(NSInteger)width Color:(UIColor *)color
{
    if (width>0) {
        self.layer.borderWidth = width;
    }
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}

@end

