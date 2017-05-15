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





@interface ClassificationViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;
@property (nonatomic,weak)UIButton *titleButton;
@property (nonatomic,strong)ClassificationConfig *configModel;

@property (nonatomic,weak) ZYSpreadButton *plusBtn;

@end

@implementation ClassificationViewController


- (IBAction)settingItem:(id)sender {
    Setting_interface_ViewController *vc = instantiateStoryboardControllerWithIdentifier(@"SettingHTNavigationController");
    [self presentViewController:vc animated:YES completion:^{}];
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];
    HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号";

    self.configModel = [[ClassificationConfig alloc]initWithController:self];
    [self.configModel drawView];
    [self.view addSubview:self.configModel.view];
    

    
    [self.configModel.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
    [self setPlusBtn];
    
    
}

-(void)setPlusBtn
{
    //我这里设置了底部的加号按钮   所以右上角的要被隐藏掉 不删掉是防止以后需要恢复
    self.navigationItem.rightBarButtonItem = nil;
    
    WeakSelf(self);
    UIImage *addImage = [UIImage imageNamed:@"add_账号"];
    addImage = [addImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    ZYSpreadSubButton *addAccount = [[ZYSpreadSubButton alloc]initWithBackgroundImage:addImage highlightImage:nil clickedBlock:^(int index, UIButton *sender) {
        
        HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];
        HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
        [weakself presentViewController:nav animated:YES completion:nil];
    }];
    addAccount.bounds = CGRectMake(0, 0, 34, 34);
    addAccount.tintColor = MainTextWhiteColor;
    
    UIImage *memorandumImage = [UIImage imageNamed:@"add_笔记"];
    memorandumImage = [memorandumImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    ZYSpreadSubButton *addMemorandum = [[ZYSpreadSubButton alloc]initWithBackgroundImage:memorandumImage highlightImage:nil clickedBlock:^(int index, UIButton *sender) {
        
        HTNavigationController *nav = instantiateStoryboardControllerWithIdentifier(@"notesHTNavigationController");
        [weakself presentViewController:nav animated:YES completion:nil];

    }];
    addMemorandum.bounds = CGRectMake(0, 0, 34, 34);
    addMemorandum.tintColor = MainTextWhiteColor;

    UIImage *plusImage = [UIImage imageNamed:@"add_post_animate"];
    plusImage = [plusImage imageWithRenderingMode:UIImageRenderingModeAutomatic];
    ZYSpreadButton *plus = [[ZYSpreadButton alloc]initWithBackgroundImage:plusImage highlightImage:nil position:CGPointMake(IPHONE_WIDTH*0.5, IPHONE_HEIGHT-30)];
    [plus setSubButtons:@[addAccount,addMemorandum]];
    [self.view addSubview:plus];
    self.plusBtn = plus;
    
    plus.direction = SpreadDirectionTop;
    plus.radius = 80;
    plus.mode = SpreadModeFlowerSpread;
    plus.positionMode = SpreadPositionModeFixed;
    plus.coverColor = [MainColorManager mainCoverColor];
    plus.coverAlpha = 0.6;
    
    [plus setButtonWillSpreadBlock:^(ZYSpreadButton *spreadButton)
    {
        
    }];
    
    [plus setButtonDidSpreadBlock:^(ZYSpreadButton *spreadButton)
    {
        
    }];
    
    [plus setButtonWillCloseBlock:^(ZYSpreadButton *spreadButton)
    {
        
    }];
    
    [plus setButtonDidCloseBlock:^(ZYSpreadButton *spreadButton)
    {
        
    }];
    
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

- (UIViewController *)nextCollectViewController
{
    HTNavigationController *nav = instantiateStoryboardControllerWithIdentifier(@"CollecHTNavigationController");
    return nav;
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

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
