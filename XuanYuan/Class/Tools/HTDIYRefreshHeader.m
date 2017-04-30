//
//  HTDIYRefreshHeader.m
//  XuanYuan
//
//  Created by King on 2017/4/26.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTDIYRefreshHeader.h"


@interface HTDIYRefreshHeader()
@end

@implementation HTDIYRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeFiveDots tintColor:MainRGB size:20.0f];
    
    [self addSubview:activityIndicatorView];
    self.activityIndicatorView = activityIndicatorView;

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    self.activityIndicatorView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    [self.activityIndicatorView startAnimating];


//    switch (state) {
//        case MJRefreshStateIdle:
//            break;
//        case MJRefreshStatePulling:
//            break;
//        case MJRefreshStateRefreshing:
//            break;
//        default:
//            break;
//    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

}


@end
