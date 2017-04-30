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

@implementation AppDelegate (HT)
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



@end
