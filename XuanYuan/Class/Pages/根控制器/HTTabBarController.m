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
    
    if (DEBUG) {
        UIScreenEdgePanGestureRecognizer* screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
        screenEdgePan.edges = UIRectEdgeLeft;
        [self.tabBar addGestureRecognizer:screenEdgePan];
    }

}


-(void)action:(UIScreenEdgePanGestureRecognizer*)sender{
    if (sender.edges == UIRectEdgeLeft) {
        switch (sender.state) {
                case UIGestureRecognizerStateBegan:
                NSLog(@"手势开始");
                break;
                case UIGestureRecognizerStateChanged:
                NSLog(@"手势进行中");
                break;
                case UIGestureRecognizerStateEnded:
                NSLog(@"手势结束");
                break;
                
            default:
                break;
        }
        if ([ZYTestManager shareInstance].isExist == NO) {
            [TestManagerConfig setupTestManager];
        }
    }
}

-(void)testZYTestManager
{
    if ([ZYTestManager shareInstance].isExist == NO) {
        //悬浮球
        [TestManagerConfig setupTestManager];
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
