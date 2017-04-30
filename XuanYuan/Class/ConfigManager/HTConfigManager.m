//
//  HTconfigManager.m
//  XuanYuan
//
//  Created by King on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTConfigManager.h"
#import "HTDataBaseManager.h"

@interface HTConfigManager()

@end

@implementation HTConfigManager



-(void)clearAllData
{
    [[HTDataBaseManager sharedInstance]clearAccountList];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStartPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStartTouchIDUserDefaults];
}



-(void)isOpenStartPassword:(BOOL)isopen
{
    NSNumber *isOpenPassword = [NSNumber numberWithBool:isopen];
    [[NSUserDefaults standardUserDefaults] setObject:isOpenPassword forKey:kStartPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isOpenStartPassword
{
    NSNumber *isOpenPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kStartPasswordUserDefaults];
    return isOpenPassword.boolValue;
}
-(void)startPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)startPassword
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordUserDefaults];
    return password;
}



-(void)isOpenTouchID:(BOOL)isOpen
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isOpen] forKey:kStartTouchIDUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isOpenTouchID
{
    NSNumber *isOpen = [[NSUserDefaults standardUserDefaults] objectForKey:kStartTouchIDUserDefaults];
    return isOpen.boolValue;
}

























static HTConfigManager *sharedconfigManager = nil;

+ (instancetype)sharedconfigManager
{
    @synchronized(self)
    {
        if (sharedconfigManager == nil)
        {
            sharedconfigManager = [[self alloc] init];
        }
    }
    
    return sharedconfigManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedconfigManager == nil)
        {
            sharedconfigManager = [super allocWithZone:zone];
            return sharedconfigManager;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
