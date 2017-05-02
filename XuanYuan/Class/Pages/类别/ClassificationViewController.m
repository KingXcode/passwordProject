//
//  ClassificationViewController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassificationConfig.h"
#import "Setting_interface_ViewController.h"
#import "HTAddItemsViewController.h"
#import "HTNavigationController.h"





@interface ClassificationViewController ()<RZTransitionInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;
@property (nonatomic,weak)UIButton *titleButton;
@property (nonatomic, strong) id<RZTransitionInteractionController> presentInteractionController;

@property (nonatomic,strong)ClassificationConfig *configModel;



@end

@implementation ClassificationViewController

- (IBAction)settingItem:(id)sender {
    Setting_interface_ViewController *vc = instantiateStoryboardControllerWithIdentifier(@"SettingHTNavigationController");
    [self presentViewController:vc animated:YES completion:^{}];
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"moveIn" direction:@"fromTop" time:0.4] forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号";

    self.configModel = [[ClassificationConfig alloc]initWithController:self];
    [self.configModel drawView];
    [self.view addSubview:self.configModel.view];
    [self annimation];
    
}

-(UIButton *)titleButton
{
    if (_titleButton == nil) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:@"下标"] forState:UIControlStateNormal];
        [titleButton setBackgroundImage:[HTTools ht_createImageWithColor:RGBA(34, 34, 34, 0.3)] forState:UIControlStateHighlighted];
        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [titleButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [titleButton addTarget:self action:@selector(clickTopButton) forControlEvents:UIControlEventTouchUpInside];
        titleButton.layer.cornerRadius = 4;
        titleButton.layer.masksToBounds = YES;
        [titleButton sizeToFit];
        self.navigationItem.titleView = titleButton;
        _titleButton = titleButton;
    }
    return _titleButton;
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
    [self presentViewController:[self nextCollectViewController] animated:YES completion:nil];
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setInteractionController];

}













-(void)annimation
{
    self.presentInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [self.presentInteractionController setNextViewControllerDelegate:self];
    [self.presentInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    
    [[RZTransitionsManager shared] setAnimationController:[[RZCirclePushAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PresentDismiss];
}


-(void)setInteractionController
{
    [[RZTransitionsManager shared] setInteractionController:self.presentInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];
}



- (UIViewController *)nextCollectViewController
{
    HTNavigationController *nav = instantiateStoryboardControllerWithIdentifier(@"CollecHTNavigationController");
    [nav setTransitioningDelegate:[RZTransitionsManager shared]];
    
//    RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
//    [dismissInteractionController attachViewController:nav withAction:RZTransitionAction_Dismiss];
//    
//    [[RZTransitionsManager shared] setInteractionController:dismissInteractionController
//                                         fromViewController:[self class]
//                                           toViewController:nil
//                                                  forAction:RZTransitionAction_Dismiss];
    return nav;
}

#pragma mark - RZTransitionInteractorDelegate
- (UIViewController *)nextViewControllerForInteractor:(id<RZTransitionInteractionController>)interactor
{
    return [self nextCollectViewController];
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
