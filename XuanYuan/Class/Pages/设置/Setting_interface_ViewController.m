//
//  Setting_interface_ViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/25.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//



#import "Setting_interface_ViewController.h"
#import "HTDataBaseManager.h"
#import "HTCheckViewController.h"

@interface Setting_interface_ViewController ()

@property (nonatomic,weak)UIButton *titleButton;


@property (weak, nonatomic) IBOutlet UITableViewCell *clearCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *startPassWordCell;
@property (weak, nonatomic) IBOutlet UISwitch *openandclosePassWordSwitch;

@property (weak, nonatomic) IBOutlet UITableViewCell *touchIDCell;
@end

@implementation Setting_interface_ViewController
- (IBAction)dismiss:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 点击顶部按钮
 */
-(void)clickTopButton
{
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleButton];
    self.title = @"设置";
    
    self.tableView.backgroundColor = MainTableViewBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    
    [self reloadStartPassWordCell];
    [self reloadTouchIdcell];
    
    
}

#pragma -mark-  刷新cell
//刷新修改密码cell  kStartPasswordUserDefaults
-(void)reloadStartPassWordCell
{
    NSNumber *isOpenPassword = [[NSUserDefaults standardUserDefaults]objectForKey:kStartPasswordUserDefaults];
    self.touchIDCell.hidden = !isOpenPassword.boolValue;
    
    self.openandclosePassWordSwitch.on = isOpenPassword.boolValue;
}

- (IBAction)isOpenPassword:(UISwitch *)sender {
    NSNumber *isOpenPassword = [NSNumber numberWithBool:sender.on];
    self.touchIDCell.hidden = !isOpenPassword.boolValue;
    
    [[NSUserDefaults standardUserDefaults] setObject:isOpenPassword forKey:kStartPasswordUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//刷新touchid cell
-(void)reloadTouchIdcell
{
    NSNumber *isStartTouchID = [[NSUserDefaults standardUserDefaults]objectForKey:kStartTouchIDUserDefaults];
    if (isStartTouchID.boolValue) {
        self.touchIDCell.textLabel.text = @"关闭Touch-ID";
    }else{
        self.touchIDCell.textLabel.text = @"启用Touch-ID";
    }
}






#pragma -mark-  cell点击事件
/**
 点击修改密码
 */
-(void)startPasswordChange
{
    UIImageView *imageView = [HTTools gaussianBlurWithMainRootView];
    HTCheckViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTCheckViewController");
    vc.image = imageView;
    vc.isChangePassword = YES;
    [self presentViewController:vc animated:YES completion:^{}];
}



//启用touchid
-(void)enableTouchID
{
    NSString *buttonText;
    NSString *subTitle;

    NSNumber *isStartTouchID = [[NSUserDefaults standardUserDefaults]objectForKey:kStartTouchIDUserDefaults];
    if (isStartTouchID.boolValue) {
        buttonText = @"关闭";
        subTitle = @"是否关闭Touch-ID进行验证";
        isStartTouchID = @NO;
    }else{
        buttonText = @"启用";
        subTitle = @"是否启用Touch-ID进行验证";
        isStartTouchID = @YES;
    }

    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert addButton:buttonText actionBlock:^(void) {
        [[NSUserDefaults standardUserDefaults] setObject:isStartTouchID forKey:kStartTouchIDUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self reloadTouchIdcell];

    }];
    UIImage *image = [UIImage imageNamed:@"lock-锁"];
    alert.iconTintColor = [UIColor whiteColor];
    [alert showCustom:self.navigationController image:image color:MainRGB title:@"提示" subTitle:subTitle closeButtonTitle:@"取消" duration:0.0f];
    
}



/**
 清空缓存
 */
-(void)showClearWarningAlert
{
    __weak typeof(self) __self = self;
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert addButton:@"确定" actionBlock:^(void) {
        [__self clearAllData];
    }];
    
    [alert showCustom:self.navigationController image:[UIImage imageNamed:@"warning_delete"] color:MainRGB title:@"警告" subTitle:@"永久删除您所记录的账号密码信息?(此操作不可恢复)" closeButtonTitle:@"取消" duration:0.0f];
    
    
}

//清除全部账号信息
-(void)clearAllData
{
    [[HTDataBaseManager sharedInstance]clearAccountList];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadClassification_Noti object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
}



#pragma -mark-  tableView 代理数据源方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [self showClearWarningAlert];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        [self startPasswordChange];
        
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self enableTouchID];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
