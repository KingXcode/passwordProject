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



@implementation AppDelegate (HT)

-(void)setShortcutIcon
{
    UIApplicationShortcutIcon *addShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *addShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.niesiyang.add" localizedTitle:@"添加账号" localizedSubtitle:@"创建一个新的账号信息" icon:addShortcutIcon userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[addShortcutItem];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"com.niesiyang.add"])
    {
        HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        HTTabBarController *tab = MainRootTabbarController;
        HTNavigationController *nav = tab.selectedViewController;
        [nav.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"moveIn" direction:@"fromTop" time:0.4] forKey:nil];
        [nav pushViewController:vc animated:NO];
    }
}




//进入验证界面
-(void)checkController
{
    
    UIViewController *currentvc = [HTTools getCurrentVC];
    if ([currentvc isKindOfClass:[HTCheckViewController class]]) {
        return;
    }
    
    [self.backgroundView removeFromSuperview];
    UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];
    self.backgroundView = imageView;
    [MainKeyWindow addSubview:self.backgroundView];
    BOOL isOpenPassword = [MainConfigManager isOpenStartPassword];
    
    NSString *password = [MainConfigManager startPassword];
    
    if (isOpenPassword &&! [HTTools ht_isBlankString:password]) {
        HTCheckViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTCheckViewController");
        vc.image = imageView;
        [currentvc presentViewController:vc animated:YES completion:^{}];
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
