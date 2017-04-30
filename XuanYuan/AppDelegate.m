//
//  AppDelegate.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/16.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+HT.h"
#import "HTCheckViewController.h"
#import "HTTabBarController.h"

@interface AppDelegate ()

@property (nonatomic,weak)UIImageView *backgroundView;

@end

@implementation AppDelegate

-(void)setShortcutIcon
{
    UIApplicationShortcutIcon *addShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *addShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.niesiyang.add" localizedTitle:@"添加账号" localizedSubtitle:@"创建一个新的账号信息" icon:addShortcutIcon userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[addShortcutItem];
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    HTTabBarController *tabbar = instantiateStoryboardControllerWithIdentifier(@"HTTabBarController");
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = tabbar;
    
    [self.window makeKeyAndVisible];
    
    [self setShortcutIcon];
    
    [self launchCheck];
    
    
    return YES;
}



//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {

    [self checkController];


}

//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {

    
}

//取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [self.backgroundView removeFromSuperview];
    UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];
    self.backgroundView = imageView;
    [MainKeyWindow addSubview:self.backgroundView];
}

//程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self.backgroundView removeFromSuperview];
    
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


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
