//
//  HTTabBarController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//  

#import "HTTabBarController.h"
#import "ZYTestManager.h"
#import "TestManagerConfig.h"

@interface HTTabBarController ()

@end

@implementation HTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tabBar.tintColor = MainTextWhiteColor;
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.layer.cornerRadius = 5;
    self.tabBar.layer.masksToBounds = YES;
    self.tabBar.layer.borderWidth = 1;
    self.tabBar.layer.borderColor = MainRGB.CGColor;
    self.tabBar.backgroundImage = [HTTools ht_createImageWithColor:MainRGB];
    
    
    
    UIScreenEdgePanGestureRecognizer* screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];

}


-(void)action:(UIScreenEdgePanGestureRecognizer*)sender{
    BOOL isDebug = [MainConfigManager isDebug];
    if (sender.edges == UIRectEdgeLeft) {
        if ([ZYTestManager shareInstance].isExist == NO && isDebug) {
            [TestManagerConfig setupTestManager];
        }
    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
