//
//  HTRecordViewController.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTRecordViewController.h"
#import "HTCheckPasswordErrorModel.h"

@interface HTRecordViewController ()


@end

@implementation HTRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HTCheckPasswordErrorModel *model = [HTCheckPasswordErrorModel getModelArray].firstObject;
    UIImageView *ima = [[UIImageView alloc]initWithImage:[HTCheckPasswordErrorModel stringToImage:model.imageString]];
    
    ima.frame = CGRectMake(50, 100, 200, 200);
    [self.view addSubview:ima];
    
    
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
