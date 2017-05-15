//
//  Setting_interface_ViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/25.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//



#import "Setting_interface_ViewController.h"
#import "HTDataBaseManager.h"
#import "HTRecordViewController.h"

@interface Setting_interface_ViewController ()

@property (nonatomic,weak)UIButton *titleButton;


@property (weak, nonatomic) IBOutlet UITableViewCell *clearCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *startPassWordCell;
@property (weak, nonatomic) IBOutlet UILabel *startPassWordLabel;
@property (weak, nonatomic) IBOutlet UISwitch *openandclosePassWordSwitch;

@property (weak, nonatomic) IBOutlet UITableViewCell *isThirdKeyBoardCell;
@property (weak, nonatomic) IBOutlet UILabel *isThirdKeyBoardLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isThirdKeyBoardSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *changeColorCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sendEmailCell;

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
    
    BOOL isDebug = [MainConfigManager isDebug];
    if (isDebug) {
        [self.view makeToast:@"关闭DebugMode" duration:1 position:[NSValue valueWithCGPoint:CGPointMake(IPHONE_WIDTH*0.5, IPHONE_HEIGHT*0.5)]];
    }else
    {
        [self.view makeToast:@"启用DebugMode" duration:1 position:[NSValue valueWithCGPoint:CGPointMake(IPHONE_WIDTH*0.5, IPHONE_HEIGHT*0.5)]];
    }
    [MainConfigManager isDebug:!isDebug];


}














-(void)setTitleButton
{
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[HTTools ht_createImageWithColor:RGBA(34, 34, 34, 0.3)] forState:UIControlStateHighlighted];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    titleButton.layer.cornerRadius = 4;
    titleButton.layer.masksToBounds = YES;
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopButton)];
    tap.numberOfTapsRequired = 5;
    [titleButton addGestureRecognizer:tap];
    
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
    [self reloadIsThirdKeyBoardCell];
    [self reloadSendEmailCell];
    [self reloadChangeColorCell];
    
}

#pragma -mark-  刷新cell
-(void)reloadChangeColorCell
{
    UIImageView *view = [UIImageView new];
    view.image = [HTTools ht_createImageWithColor:[MainConfigManager mainRGB]];
    view.bounds = CGRectMake(0, 0, 30, 30);
    self.changeColorCell.accessoryView = view;
}

/**
 发送邮件
 */
-(void)reloadSendEmailCell
{
    BOOL isSend = [MainConfigManager canSendEmail];
    if (!isSend) {
        self.sendEmailCell.textLabel.text = @"吐槽微密(不可用)";
    }
    self.sendEmailCell.userInteractionEnabled = isSend;
}
//刷新修改密码cell
-(void)reloadStartPassWordCell
{
    NSString *password = [MainConfigManager startPassword];
    
    if ([HTTools ht_isBlankString:password]) {

        self.openandclosePassWordSwitch.enabled = NO;
        
    }else
    {
        self.openandclosePassWordSwitch.enabled = YES;
    }
    
    BOOL isOpenPassword = [MainConfigManager isOpenStartPassword];
    self.touchIDCell.userInteractionEnabled = isOpenPassword;
    self.openandclosePassWordSwitch.on = isOpenPassword;
}

-(void)reloadIsThirdKeyBoardCell
{
    self.isThirdKeyBoardSwitch.on = [[HTConfigManager sharedconfigManager] isAllowThirdKeyboard];
}


//刷新touchid cell
-(void)reloadTouchIdcell
{
    BOOL isStartTouchID = [MainConfigManager isOpenTouchID];
    if (isStartTouchID) {
        self.touchIDCell.textLabel.text = @"关闭Touch-ID";
    }else{
        self.touchIDCell.textLabel.text = @"启用Touch-ID";
    }
}



#pragma -mark-  cell点击事件

-(void)pushRecordViewController
{
    HTRecordViewController *record = instantiateStoryboardControllerWithIdentifier(@"HTRecordViewController");
    
    [self.navigationController pushViewController:record animated:YES];
}

/**
 修改主题颜色
 */
-(void)changeColor
{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    SCLButton *btn1 = [alert addButton:@"默认" actionBlock:^{
        
        [MainConfigManager mainRGB:RGB(0, 191, 255)];
        
    }];
    btn1.defaultBackgroundColor = RGB(0, 191, 255);
    
    SCLButton *btn2 = [alert addButton:@"深灰色" actionBlock:^{
       
        [MainConfigManager mainRGB:[UIColor darkGrayColor]];

    }];
    btn2.defaultBackgroundColor = [UIColor darkGrayColor];

    alert.iconTintColor = [UIColor whiteColor];
    [alert showCustom:self.navigationController image:[UIImage imageNamed:@"settings-设置"] color:MainRGB title:@"提示" subTitle:@"更改APP的主题颜色" closeButtonTitle:@"取消" duration:0.0f];
}

/**
 发送邮件
 */
-(void)sendEmail
{
    NSString *subject = @"微密-反馈邮件";
    NSString *recipients = @"siyang.nie.520@gmail.com";
    NSString *body = [NSString stringWithFormat:@"机器型号:%@\n系统版本:%@\n反馈问题:\n",[HTTools deviceVersion],[HTTools phoneVersion]];
    [MainConfigManager sendEmailActionWithSubject:subject Recipients:recipients MessageBody:body];
}




/**
 是否启用启动密码
 */
- (IBAction)isOpenPassword:(UISwitch *)sender {
    

    BOOL isOpen = [MainConfigManager isOpenStartPassword];
    if (!isOpen && sender.on) {
        [MainConfigManager isOpenStartPassword:sender.on];
        self.touchIDCell.userInteractionEnabled = sender.on;
    }else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        SCLTextView *textField = [alert addTextField:@"请输入密码"];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.tintColor = MainTextColor;
        
        NSString *password = [MainConfigManager startPassword];

        [alert addButton:@"确定" validationBlock:^BOOL{

            if ([password isEqualToString:textField.text]) {
                
                return YES;
            }else
            {
                textField.placeholder = @"密码错误";
                
                [HTTools shakeAnnimation:textField completion:^(BOOL finished) {
                    
                }];
                [HTTools vibrate];
                
                return NO;
            }
        
        } actionBlock:^{
            
            [MainConfigManager isOpenStartPassword:sender.on];
            [self reloadStartPassWordCell];
            self.touchIDCell.userInteractionEnabled = sender.on;
            
        }];
        
        [alert addButton:@"取消" actionBlock:^{
            sender.on = !sender.on;
        }];
        
        UIImage *image = [UIImage imageNamed:@"lock-锁"];
        alert.iconTintColor = [UIColor whiteColor];
        [alert showCustom:self.navigationController image:image color:MainRGB title:@"提示" subTitle:@"是否关闭启动密码验证\n并且删除密码" closeButtonTitle:nil duration:0.0f];
        
    }
    
    
    

}





/**
 是否启用第三方键盘
 */
- (IBAction)isThirdKeyBoard:(UISwitch *)sender {
    [[HTConfigManager sharedconfigManager] isAllowThirdKeyboard:sender.on];
}

/**
 点击修改密码
 */
-(void)startPasswordChange
{
    NSString *title;
    NSString *subTitle;
    NSString *password = [MainConfigManager startPassword];
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    SCLTextView *textField0;
    if ([HTTools ht_isBlankString:password]) {
        title = @"设置密码";
        subTitle = @"请设置启动密码";
    }else
    {
        title = @"修改密码";
        subTitle = @"请修改启动密码";
        textField0 = [alert addTextField:@"请输入原密码"];
        textField0.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    
    SCLTextView *textField1 = [alert addTextField:@"请输入新密码"];
    SCLTextView *textField2 = [alert addTextField:@"请再一次输入密码"];
    
    textField1.keyboardType = UIKeyboardTypeNumberPad;
    textField1.tintColor = MainTextColor;
    textField2.keyboardType = UIKeyboardTypeNumberPad;
    textField2.tintColor = MainTextColor;

    [alert addButton:@"确定" validationBlock:^BOOL{
        

        if (!(!textField0||(textField0&&[MainConfigManager checkInputPassword:textField0.text]))) {
            textField0.text = nil;
            textField0.placeholder = @"密码错误";
            [HTTools shakeAnnimation:textField0 completion:^(BOOL finished) {
                
            }];
            [HTTools vibrate];
            return NO;
        }
        

        if ([HTTools ht_isBlankString:textField1.text]||[HTTools ht_isBlankString:textField2.text]) {
            
            textField1.placeholder = @"输入不能为空";
            textField2.placeholder = @"输入不能为空";
            [HTTools shakeAnnimation:textField1 completion:^(BOOL finished) {
                
            }];
            [HTTools shakeAnnimation:textField2 completion:^(BOOL finished) {
                
            }];
            [HTTools vibrate];
            return NO;
        }
        else if (![textField1.text isEqualToString:textField2.text]) {
            textField2.text = nil;
            textField2.placeholder = @"两次密码输入不一致";
            [HTTools shakeAnnimation:textField2 completion:^(BOOL finished) {
                
            }];
            [HTTools vibrate];
            return NO;
        }
        else
        {
            return YES;
        }
    } actionBlock:^{
        
        [MainConfigManager startPassword:textField1.text];
        [self reloadStartPassWordCell];

    }];
    
    [alert addButton:@"取消" actionBlock:^{
        
    }];
    
    UIImage *image = [UIImage imageNamed:@"lock-锁"];
    alert.iconTintColor = [UIColor whiteColor];
    [alert showCustom:self.navigationController image:image color:MainRGB title:title subTitle:subTitle closeButtonTitle:nil duration:0.0f];
}



//启用touchid
-(void)enableTouchID
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];

    
    NSString *buttonText;
    NSString *subTitle;

    BOOL isStartTouchID = [MainConfigManager isOpenTouchID];
    
    if (isStartTouchID) {
        buttonText = @"关闭";
        subTitle = @"是否关闭Touch-ID进行验证";
        isStartTouchID = NO;
        
        SCLTextView *textField = [alert addTextField:@"请输入密码"];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.tintColor = MainTextColor;
        
        NSString *password = [MainConfigManager startPassword];
        
        [alert addButton:buttonText validationBlock:^BOOL{
            
            if ([password isEqualToString:textField.text]) {
                
                return YES;
            }else
            {
                textField.placeholder = @"密码错误";
                
                [HTTools shakeAnnimation:textField completion:^(BOOL finished) {
                    
                }];
                [HTTools vibrate];
                
                return NO;
            }
            
        } actionBlock:^{
            
            [MainConfigManager isOpenTouchID:isStartTouchID];
            [self reloadTouchIdcell];
            
        }];


        
    }else{
        
        buttonText = @"启用";
        subTitle = @"是否启用Touch-ID进行验证";
        isStartTouchID = YES;
        
        [alert addButton:buttonText actionBlock:^(void) {
            
            [MainConfigManager isOpenTouchID:isStartTouchID];
            [self reloadTouchIdcell];
            
        }];

    }
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
    NSString *password = [MainConfigManager startPassword];

    SCLAlertView *alert = [[SCLAlertView alloc] init];
    SCLTextView *textField1;
    
    if (![HTTools ht_isBlankString:password]) {
        
        textField1 = [alert addTextField:@"请输入密码"];
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField1.tintColor = MainTextColor;
        
    }

    
    [alert addButton:@"确定" validationBlock:^BOOL{
        if ([HTTools ht_isBlankString:password])
        {
            return YES;
        }
        else if ([MainConfigManager checkInputPassword:textField1.text])
        {
            return YES;
        }
        else
        {
            textField1.text = nil;
            textField1.placeholder = @"密码错误";
            [HTTools shakeAnnimation:textField1 completion:^(BOOL finished) {
                
            }];
            [HTTools vibrate];
            return NO;
        }
    } actionBlock:^{
        [__self clearAllData];
    }];
    
    [alert showCustom:self.navigationController image:[UIImage imageNamed:@"warning_delete"] color:MainRGB title:@"警告" subTitle:@"永久删除您所记录的账号密码信息?\n(此操作不可恢复)" closeButtonTitle:@"取消" duration:0.0f];
    
    
}

//清除全部账号信息
-(void)clearAllData
{

    [MainConfigManager clearAllData];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadClassification_Noti object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];

}

//默认设置
-(void)defaultSetting
{
    
    __weak typeof(self) __self = self;
    NSString *password = [MainConfigManager startPassword];

    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    SCLTextView *textField1;
    
    if (![HTTools ht_isBlankString:password]) {
       
        textField1 = [alert addTextField:@"请输入密码"];
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField1.tintColor = MainTextColor;
        
    }

    
    [alert addButton:@"确定" validationBlock:^BOOL{
        
        if ([HTTools ht_isBlankString:password])
        {
            return YES;
        }
        else if ([MainConfigManager checkInputPassword:textField1.text])
        {
            return YES;
        }
        else
        {
            textField1.text = nil;
            textField1.placeholder = @"密码错误";
            [HTTools shakeAnnimation:textField1 completion:^(BOOL finished) {
                
            }];
            [HTTools vibrate];
            return NO;
        }
    } actionBlock:^{
        [MainConfigManager defaultSetting];
        [__self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    

    
    [alert showCustom:self.navigationController image:[UIImage imageNamed:@"warning_delete"] color:MainRGB title:@"警告" subTitle:@"恢复默认设置?\n(此操作不可恢复)" closeButtonTitle:@"取消" duration:0.0f];
    
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
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        [self showClearWarningAlert];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self defaultSetting];
    }
    else if (indexPath.section == 0 && indexPath.row == 2)
    {

    }
    else if (indexPath.section == 0 && indexPath.row == 3)
    {
        [self pushRecordViewController];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self startPasswordChange];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self enableTouchID];
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        [self changeColor];
    }
    else if (indexPath.section == 3 && indexPath.row == 0)
    {
        [self sendEmail];
    }
    else if (indexPath.section == 4 && indexPath.row == 0)
    {
        [[HTConfigManager sharedconfigManager]openSourceCodeWebView];
    }
    else if (indexPath.section == 4 && indexPath.row == 1)
    {
        [[HTConfigManager sharedconfigManager]openBlogWebView];
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
