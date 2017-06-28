//
//  NSArray+HTTools.m
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "NSArray+HTTools.h"

@implementation NSArray (HTTools)

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
 *    ..如果该数组内的元素是可以进行排序的,那你他妈就不要用这个方法啊,系统提供了那么多排序方法   ---  有没有感受到我深深的恶意...
 *    ..如果该数组内的元素是可以进行排序的,这个方法也可以实现 用后面的字典 ---  @{@"self":[NSNumber numberWithBool:YES]}
 *    return  排序后的新数组
 */
-(NSArray *)ht_SortModelArrarInfo:(NSDictionary *)info
{
    NSMutableArray *sortDescriptorArray = [NSMutableArray array];
    NSArray *infoKeyArray = [info allKeys];
    
    for (int i = 0; i < infoKeyArray.count; i++) {
        NSString *key = infoKeyArray[i];
        NSNumber *value = [info objectForKey:key];
        NSSortDescriptor *des = [[NSSortDescriptor alloc]initWithKey:key ascending:value.boolValue];
        [sortDescriptorArray addObject:des];
    }
    
    NSArray *newA = [self sortedArrayUsingDescriptors:sortDescriptorArray];
    return newA;
}





//反序数组
-(NSArray *)ht_reverse
{
    NSArray *reversArray = [[self reverseObjectEnumerator] allObjects];
    return reversArray;
}






//去除重复的元素
-(NSArray *)ht_removeRepeatRows
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self count]; i++){
        if ([categoryArray containsObject:[self objectAtIndex:i]] == NO){
            [categoryArray addObject:[self objectAtIndex:i]];
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
-(NSArray *)ht_removeRepeatRowsWithKeypath:(NSString *)keypath
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
    
    NSMutableArray *categoryArray = [NSMutableArray arrayWithArray:[self filteredArrayUsingPredicate:predicate]];
    
    return categoryArray;
}





@end
