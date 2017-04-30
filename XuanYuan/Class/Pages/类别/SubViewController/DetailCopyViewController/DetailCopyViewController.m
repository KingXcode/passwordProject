//
//  DetailCopyViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

//backTopView 现在是多余的

#import "DetailCopyViewController.h"
#import "DetailCopyView.h"

@interface DetailCopyViewController ()

@property (nonatomic,strong)DetailCopyView *detailView;
@property (nonatomic,strong)UIVisualEffectView *gaussianBlurImageView;

@end

@implementation DetailCopyViewController

-(DetailCopyView *)detailView
{
    if (_detailView == nil) {
        
        _detailView = [[DetailCopyView alloc]init];
        
        _detailView.backgroundColor = [UIColor whiteColor];
        _detailView.layer.opacity = 0;
        [_detailView.button addTarget:self action:@selector(copyString) forControlEvents:UIControlEventTouchUpInside];
        [_detailView.closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _detailView;
}

-(void)copyString
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if (self.detailView.textView.text.length>0) {
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string=self.detailView.textView.text;
        
        [alert showTitle:self title:@"复制成功!" subTitle:@"(您可以在其它APP中粘贴账号密码)" style:SCLAlertViewStyleSuccess closeButtonTitle:@"完成" duration:0.0f];
    }else
    {
        [alert showTitle:self title:@"复制失败!" subTitle:@"(复制的内容为空!)" style:SCLAlertViewStyleError closeButtonTitle:@"完成" duration:0.0f];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    
    UIImage *image = [HTTools captureScreen];
    self.backImageView.image = image;
    
    self.gaussianBlurImageView = [HTTools gaussianBlurWithFrame:[UIScreen mainScreen].bounds];
    self.gaussianBlurImageView.alpha = 0;

    
    [self.backImageView addSubview:self.gaussianBlurImageView];
    self.backTopView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.detailView];
    self.detailView.model = self.model;
    [self.detailView reloadData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.backTopView addGestureRecognizer:tap];
    
    
    
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.backTopView);
        make.width.mas_equalTo(IPHONE_WIDTH*0.9);
        if (IPHONE_HEIGHT<=ht_number_iPhone4_H) {
            make.height.mas_equalTo(IPHONE_HEIGHT*0.9);
        }else
        {
            make.height.mas_equalTo(IPHONE_HEIGHT*0.7);
        }
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.isPeek == NO) {
        [HTTools CATransform3DScaleView:self.detailView];
        [UIView animateWithDuration:0.4f animations:^{
            self.gaussianBlurImageView.alpha = 1;
        }];
    }else
    {
        self.detailView.layer.opacity = 1;
        self.gaussianBlurImageView.alpha = 1;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)dismiss
{

    self.backTopView.backgroundColor = [UIColor clearColor];
    CATransform3D transform = CATransform3DIdentity;
    [UIView animateWithDuration:0.4f animations:^{
        self.gaussianBlurImageView.alpha = 0;
        self.detailView.layer.transform = CATransform3DScale(transform, 0.1, 0.1, 1);;
        self.detailView.layer.opacity = 1;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
