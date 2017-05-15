//
//  HTColorManager.m
//  XuanYuan
//
//  Created by King on 2017/5/2.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTColorManager.h"

@implementation HTColorManager





-(UIColor *)mainRGB
{
    return [MainConfigManager mainRGB];
}




-(UIColor *)mainTextColor
{
    return [UIColor darkGrayColor];
}



-(UIColor *)mainTextWhiteColor
{
    return [UIColor whiteColor];
}

-(UIColor *)mainCollectColor
{
    return [UIColor orangeColor];
}


-(UIColor *)mainTableViewBackgroundColor
{
    return [UIColor groupTableViewBackgroundColor];
}

-(UIColor *)mainCoverColor
{
    return [UIColor darkGrayColor];
}



static HTColorManager *sharedColorManager = nil;
+ (instancetype)sharedcolorManager
{ 
    @synchronized(self)
    {
        if (sharedColorManager == nil)
        {
            sharedColorManager = [[self alloc] init];
        }
    }
    
    return sharedColorManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedColorManager == nil)
        {
            sharedColorManager = [super allocWithZone:zone];
            return sharedColorManager;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
