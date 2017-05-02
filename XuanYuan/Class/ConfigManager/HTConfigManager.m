//
//  HTconfigManager.m
//  XuanYuan
//
//  Created by King on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTConfigManager.h"
#import "HTDataBaseManager.h"
#import <MessageUI/MessageUI.h>

@interface HTConfigManager()<MFMailComposeViewControllerDelegate>

@end

@implementation HTConfigManager



-(void)clearAllData
{
    [[HTDataBaseManager sharedInstance]clearAccountList];

}

-(void)defaultSetting
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStartPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStartTouchIDUserDefaults];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAllowThirdKeyboardUserDefaults];
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

-(BOOL)checkInputPassword:(NSString *)inputPassword
{
    if ([inputPassword isEqualToString:[self startPassword]]) {
        return YES;
    }else
    {
        return NO;
    }
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



-(void)isAllowThirdKeyboard:(BOOL)isAllow
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isAllow] forKey:kAllowThirdKeyboardUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isAllowThirdKeyboard
{
    NSNumber *isAllow = [[NSUserDefaults standardUserDefaults] objectForKey:kAllowThirdKeyboardUserDefaults];
    return isAllow.boolValue;
}


-(void)openSourceCodeWebView
{
    [HTTools openSafariServiceWithUrl:[NSURL URLWithString:@"https://github.com/KingXcode/passwordProject"] byController:[HTTools getCurrentVC]];
}

-(void)openBlogWebView
{
    [HTTools openSafariServiceWithUrl:[NSURL URLWithString:@"http://www.niesiyang.cn"] byController:[HTTools getCurrentVC]];
}





/**
 能否发送邮件
 */
-(BOOL)canSendEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        return YES;
    }else
    {
        return NO;
    }
}


/**
 发送邮件

 @param subject 设置邮件主题
 @param recipients 设置收件人
 @param emailContent 邮件内容
 */
- (void)sendEmailActionWithSubject:(NSString *)subject
                        Recipients:(NSString *)recipients
                       MessageBody:(NSString *)emailContent
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    [mailCompose setMailComposeDelegate:self];
    [mailCompose setSubject:subject];
    [mailCompose setToRecipients:@[recipients]];
    [mailCompose setMessageBody:emailContent isHTML:NO];
    [[HTTools getCurrentVC] presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [[HTTools getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
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
