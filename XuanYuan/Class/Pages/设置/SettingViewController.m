//
//  SettingViewController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "SettingViewController.h"
#import "HTDataBaseManager.h"

@interface SettingViewController ()
@property (nonatomic,weak)UIButton *titleButton;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitleButton];
    self.title = @"设置";
}

-(void)setTitleButton
{
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[HTTools ht_createImageWithColor:RGBA(34, 34, 34, 0.3)] forState:UIControlStateHighlighted];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    [titleButton addTarget:self action:@selector(clickTopButton) forControlEvents:UIControlEventTouchUpInside];
    
    titleButton.layer.cornerRadius = 4;
    titleButton.layer.masksToBounds = YES;
    
    
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self.titleButton sizeToFit];
}

/**
 点击顶部按钮
 */
-(void)clickTopButton
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[HTDataBaseManager sharedInstance]clearAccountList];
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
