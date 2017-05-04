//
//  HTNavigationController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTNavigationController.h"

@interface HTNavigationController ()

@end

@implementation HTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = MainRGB;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = MainTableViewBackgroundColor;
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
