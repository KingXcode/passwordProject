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
    // Do any additional setup after loading the view.
    self.selectedIndex = 1;
    self.tabBar.tintColor = MainRGB;
    self.tabBar.barStyle = UIBarStyleDefault;
//    [self.tabBar removeFromSuperview];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [self.tabBar addGestureRecognizer:tap];
 
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable&&version.integerValue>=10) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.tabBar];
    }
    
}




-(void)tap:(UITapGestureRecognizer *)tap
{
    [HTTools openSafariServiceWithUrl:[NSURL URLWithString:@"https://www.baidu.com"] byController:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{

    SFSafariViewController *vc = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"http://www.niesiyang.cn"]];
    return vc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
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
