//
//  HTTools+Array.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

//这个工具主要是用来排序的

#import "HTTools.h"

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





/**
 反序数组

 @param object 需要反序的原数组
 @return 反序后的新数组
 */
+(NSArray *)ht_reverseArray:(NSArray *)object;





/**
 去除重复的元素

 @param object 需要去除重复元素的数组
 @return 已经去除重复元素的新数组
 */
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
