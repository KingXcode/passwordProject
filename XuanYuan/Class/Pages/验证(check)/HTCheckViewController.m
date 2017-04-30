//
//  HTCheckViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/28.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTCheckViewController.h"


@interface HTCheckViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (nonatomic,copy)NSString *password;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic,strong)NSMutableString *inputString;
@end

@implementation HTCheckViewController

-(NSMutableString *)inputString
{
    if (_inputString == nil) {
        _inputString = [NSMutableString string];
    }
    return _inputString;
}

-(NSString *)password
{
    if (_password == nil) {
        _password = @"123456";
    }
    return _password;
}

- (IBAction)clickedNumberBtn:(UIButton *)sender {
    
    NSString *number = sender.titleLabel.text;
    [self.inputString appendString:number];
    self.passLabel.text = [NSString stringWithFormat:@"%@●",self.passLabel.text];
    if (self.inputString.length>=self.password.length) {
        [self check];
    }
    
}

- (IBAction)cancelBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)check
{
    if ([self.inputString isEqualToString:self.password]) {
       
        self.view.userInteractionEnabled = NO;
        
        self.showLabel.text = @"验证成功!";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        
        
    }else
    {
        self.view.userInteractionEnabled = NO;

        [self.inputString setString:@""];
        self.passLabel.text = @"";
        self.showLabel.text = @"验证失败,请重新输入";
        [HTTools shakeAnnimation:self.showLabel completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
        
        [HTTools vibrate];

    }
}

-(void)setIsChangePassword:(BOOL)isChangePassword
{
    _isChangePassword = isChangePassword;
    self.cancelButton.hidden = NO;
    [self.cancelButton setTitle:@"取消修改" forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cancelButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneInForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
}

-(void)appHasGoneInForeground:(NSNotification *)noti
{
    [self enableTouchID];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self enableTouchID];
}


-(void)enableTouchID
{
    
    [HTTools enableTouchIDCheck:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
    
}

-(void)setImage:(UIImageView *)image
{
    _image = image;
    
    [self.view insertSubview:_image atIndex:0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
