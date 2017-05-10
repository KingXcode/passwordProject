//
//  AppDelegate+HT.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/30.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate+HT.h"
#import "HTAddItemsViewController.h"
#import "HTNavigationController.h"
#import "HTCheckViewController.h"
#import "DetailCopyViewController.h"


@implementation AppDelegate (HT)


-(void)setMainRootViewController
{
    HTTabBarController *tabbar = instantiateStoryboardControllerWithIdentifier(@"HTTabBarController");
    

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
}

-(void)setShortcutIcon
{
    UIApplicationShortcutIcon *addShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *addShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"cn.niesiyang.add" localizedTitle:@"添加账号" localizedSubtitle:@"创建一个新的账号信息" icon:addShortcutIcon userInfo:nil];
    
    UIApplicationShortcutIcon *bigbangShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeBookmark];
    UIApplicationShortcutItem *bigbangShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"cn.niesiyang.bigbang" localizedTitle:@"分词" localizedSubtitle:@"将剪贴板中的内容分词" icon:bigbangShortcutIcon userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[addShortcutItem,bigbangShortcutItem];
}



-(void)openAddViewController
{
    UIViewController *currentvc = [HTTools getCurrentVC];
    if ([currentvc isKindOfClass:[HTAddItemsViewController class]]) {
        return;
    }
    
    HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];    
    HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
    [[HTTools getCurrentVC] presentViewController:nav animated:YES completion:^{
        
    }];
}



-(void)openUrlFromWeiMi:(NSURL *)url
{
    if ([url.host isEqualToString:@"BigBang"]) {
        [self openBigBangViewController];
    }
}


-(void)openBigBangViewController
{
    UIViewController *currentvc = [HTTools getCurrentVC];
    if ([currentvc isKindOfClass:[DetailCopyViewController class]]) {
        return;
    }
    
    
    ClassificationModel *model = [[ClassificationModel alloc]init];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    model.remarks = pasteboard.string;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    vc.model = model;
    vc.isPeek = NO;
    vc.isBigBang = YES;

    [[HTTools getCurrentVC] presentViewController:vc animated:YES completion:^{
        
    }];
}




//进入验证界面
-(void)checkController
{

    UIViewController *currentvc = [HTTools getCurrentVC];
    if ([currentvc isKindOfClass:[HTCheckViewController class]]) {
        return;
    }
    UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];

    BOOL isOpenPassword = [MainConfigManager isOpenStartPassword];
    NSString *password = [MainConfigManager startPassword];
    
    if (isOpenPassword &&! [HTTools ht_isBlankString:password]) {
        HTCheckViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTCheckViewController");
        vc.image = imageView;
        [[HTTools getCurrentVC] presentViewController:vc animated:YES completion:^{}];
    }
}

/**
 启动时进入
 */
-(void)launchCheck
{
    BOOL isOpenPassword = [MainConfigManager isOpenStartPassword];
    NSString *password = [MainConfigManager startPassword];
    
    if (isOpenPassword && ![HTTools ht_isBlankString:password]) {
        UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];
        HTCheckViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTCheckViewController");
        vc.image = imageView;
        [MainRootViewController presentViewController:vc animated:YES completion:^{}];
    }
}


@end
