//
//  AppDelegate.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/16.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTabBarController.h"
#import "TestManagerConfig.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

//ios9之前
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"weimi"])
    {
        [self openUrlFromWeiMi:url];
    }
    return YES;
}
//ios9之后
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.scheme isEqualToString:@"weimi"])
    {
        [self openUrlFromWeiMi:url];
    }
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"cn.niesiyang.add"])
    {
        [self openAddViewController];
    }
    else if ([shortcutItem.type isEqualToString:@"cn.niesiyang.bigbang"])
    {
        [self openBigBangViewController];
    }
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    [self setMainRootViewController];
    [self setShortcutIcon];
    [self launchCheck];
    
    return YES;
}

//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {


}

//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {

    

}


//取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [self.backgroundView removeFromSuperview];
    UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];
    imageView.alpha = 0;
    self.backgroundView = imageView;
    [MainKeyWindow addSubview:self.backgroundView];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundView.alpha = 1;
    }];
}

//程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self checkController];
    }];
    
}

//禁用三方键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return [[HTConfigManager sharedconfigManager] isAllowThirdKeyboard];
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
