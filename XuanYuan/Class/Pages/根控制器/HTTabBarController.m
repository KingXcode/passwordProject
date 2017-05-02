//
//  HTTabBarController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTabBarController.h"

@interface HTTabBarController ()

@end

@implementation HTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.tintColor = MainRGB;
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.layer.cornerRadius = 5;
    self.tabBar.layer.masksToBounds = YES;
    self.tabBar.layer.borderWidth = 1;
    self.tabBar.layer.borderColor = MainRGB.CGColor;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.frame = CGRectMake(0, IPHONE_HEIGHT-49, 49, 49);
//    self.tabBar.center = CGPointMake(IPHONE_WIDTH*0.5f, self.tabBar.center.y);


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
