//
//  TestManagerConfig.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "TestManagerConfig.h"

@interface TestManagerConfig ()<ZYTestManagerDelegate>

@end

@implementation TestManagerConfig

static TestManagerConfig *_instance;

+ (instancetype)shareInstance
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[TestManagerConfig alloc] init];
        });
    }
    return _instance;
}

+ (void)setupTestManager
{
//    [ZYTestManager shareInstance].delegate = [TestManagerConfig shareInstance];
    
    [ZYTestManager showSuspensionView];
    
    NSDictionary *action1 = @{
                              kTestTitleKey: @"隐藏悬浮球",
                              kTestAutoCloseKey: @YES,
                              kTestActionKey: ^{
                                  [ZYTestManager removeSuspensionView];
                              }
                              };
    NSDictionary *action2 = @{
                              kTestTitleKey: @"文件",
                              kTestAutoCloseKey: @YES,
                              kTestActionKey: ^{

                                  
                              }
                              };
    
    NSArray *baseArray = @[action1,action2];
    
    [ZYTestManager setupPermanentTestItemArray:baseArray];
}

#pragma mark - 点击操作


#pragma mark - ZYTestManagerDelegate
//- (UIView *)testManagerLoginTableHeaderView:(ZYTestManager *)testManager
//{
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    v.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.6];
//    return v;
//}

@end
