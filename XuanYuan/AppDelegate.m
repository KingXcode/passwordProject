//
//  AppDelegate.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/16.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTabBarController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate




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
    }];
    
}





- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
