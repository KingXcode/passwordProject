//
//  HTTools.h
//  pangu
//
//  Created by niesiyang on 2017/2/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SafariServices/SafariServices.h>






#pragma -mark-  这里是分割线--------------------

@interface HTTools : NSObject


/**
 生成随机数
 */
+(NSUInteger)getRandomNumber:(NSUInteger)from to:(NSUInteger)to;
/**
 跳转对应的控制器
 */
+ (BOOL)ht_navigation:(UINavigationController *)navigation jumpToViewControllerForString:(NSString *)ClassVc;


@end


#pragma -mark-  SafariService--------------------
@interface HTTools (SafariService)
+(SFSafariViewController *)openSafariServiceWithUrl:(NSURL *)url byController:(UIViewController *)controller;
@end



#pragma -mark-  Image--------------------

@interface HTTools (Image)

/**
 根据色值返回image
 */
+ (UIImage *)ht_createImageWithColor: (UIColor *) color;
/*
 根据传入的size讲image的尺寸重置  有一定的压缩能力
 */
+(UIImage *)ht_returnImage:(UIImage *)image BySize:(CGSize)size;
@end


#pragma -mark-  Model--------------------

@interface HTTools (Model)

/**
 转json字符串
 */
+ (NSString *)ht_DataToJsonString:(id)info;
/**
 转字典
 */
+ (NSDictionary *)ht_dictionaryWithJsonString:(NSString *)jsonString;

@end

#pragma -mark-  AOP--------------------
@interface HTTools (AOP)

/*!
 *  替换两个方法
 *
 *   className
 *   originalSelector 原始方法
 *   swizzledSelector 替换的方法
 */
+ (void)aop_swizzlingClass:(NSString *)className
          OriginalSelector:(SEL)originalSelector
          swizzledSelector:(SEL)swizzledSelector;

@end


#pragma -mark-  cache--------------------

@interface HTTools (Cache)

//效果还未测试  不开放接口

@end






#pragma -mark-  HTRegularExpression--------------------
@interface HTTools (HTRegularExpression)
//***** 验证字符串 format是正则表达式
//format:请参考RegularExpressionExample.h中的内容
+(BOOL)ht_IsVerifyString:(NSString *)string predicateWithFormat:(NSString *)format;
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



#pragma -mark-  String--------------------
@interface HTTools (String)
/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)ht_translationArabicNum:(NSInteger)arabicNum;

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
+(BOOL)ht_stringContainsEmoji:(NSString *)string;
/**
 字符串判空
 */
+ (BOOL)ht_isBlankString:(NSString *)string;
@end






#pragma -mark-  Array--------------------
/*
    NSPredicate  强推这个类,真吊炸天!!!!
 */
@interface HTTools (Array)
/*
 *    info = @{
 *             @"":[NSNumber numberWithBool:YES],
 *              ...
 *            };
 *    info    排序模型数组的相关信息
 *            key越靠前 优先级越高
 *            key    -----  为model中可以用来排序的属性   如果key是字符串等其它类型可以使用keypath的方式,如.integerValue等形式作为该字典的key
 *            value  -----  为该属性的排序方式  yes:升序   no:降序
 *              
 *            关于这个info字典需要哦解释,虽然说字典集合是无序集合,但是实际上取allkey或者allvalue时的值实际上是有序的数组,而这个数组实际上是按照我们创建的时候的顺序排列的...
 *
 *    modelArray 待排序的数组 ..如果该数组内的元素是可以进行排序的,那你他妈就不要用这个方法啊,系统提供了那么多排序方法   ---  有没有感受到我深深的恶意...
 *                          ..如果该数组内的元素是可以进行排序的,这个方法也可以实现 用后面的字典 ---  @{@"self":[NSNumber numberWithBool:YES]}
 *    return  排序后的新数组
 */
+(NSArray *)ht_SortModelArrar:(NSArray *)modelArray info:(NSDictionary *)info;

//反序数组
+(NSArray *)ht_reverseArray:(NSArray *)object;
//去除重复的元素
+(NSArray *)ht_removeRepeatRowsForArray:(NSArray *)object;

/**
 根据modelArray中的属性 去除重复的元素
 目前我的测试中 NSString 和 int类型是没有问题的,过滤正常.
 感慨一下,系统的数组提供的过滤器,排序方式真的很强大

 @param object 模型数组
 @param keypath 模型数组元素中的一个属性
 @return 过滤之后的新数组
 */
+(NSArray *)ht_removeRepeatRowsForArray:(NSArray *)object WithKeypath:(NSString *)keypath;

@end









#pragma -mark-  Date--------------------
@interface HTTools (Date)
/**
 @param timeStr 时间戳
 @param dateFormat  the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr dateFormat:(NSString *)dateFormat;
/*
 时间戳转字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr;
/**
 判断几分钟前
 */
+(NSString *)ht_compareCurrentTime:(NSDate*) compareDate;
+(NSString *)ht_compareCurrentTimes:(NSTimeInterval)timeInterval;
/**
 任意进制转换十进制 index为0原字符串默认为十六进制
 @param str 数字字符串
 @param index 字符串原本是 几进制
 @return 转换后的十进制数
 */
+(NSNumber *)ht_strToulWithStr:(NSString *)str base:(int)index;

@end



#pragma -mark-  Systerm--------------------
@interface HTTools (Systerm)

/*
 *  返回的CPU使用率
 */
+ (float)cpuUsage;
/*!
 *  跳转系统通知
 */
+ (void)gotoSystermSettings;
/*!
 *  跳转Safari浏览器
 *
 *  @param url 需要用Safari打开的url
 */
+ (void)gotoSafariBrowserWithURL:(NSString *)url;
/**
 拨打电话
 */
+ (void)ht_callPhone:(NSString *)phone;

@end




/**
 UIView的分类   方便自己使用
 */
@interface UIView (HTExtension)

@property (nonatomic) CGFloat ht_x;
@property (nonatomic) CGFloat ht_y;
@property (nonatomic) CGFloat ht_width;
@property (nonatomic) CGFloat ht_height;

-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated;


-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;



-(void)ht_setCornerRadius:(CGFloat)radius;
-(void)ht_setBorderWidth:(NSInteger)width Color:(UIColor *)color;
@end








