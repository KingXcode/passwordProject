//
//  ShareActionView.m
//  CheckIn
//
//  Created by kule on 16/1/13.
//  Copyright © 2016年 zhiye. All rights reserved.
//


#import "ShareActionView.h"
#define SHAREBUTTONWIDTH 60

@implementation ShareActionButtonView

- (instancetype)initWithFrame:(CGRect)frame WithImageName:(NSString *)iconImageName WithTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconImageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        iconImageview.image = [UIImage imageNamed:iconImageName];
        [self addSubview:iconImageview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageview.frame) + 5, self.frame.size.width, 15)];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
    }
    return self;
}

@end

#import "AppDelegate.h"
@interface ShareActionView ()

@property (nonatomic, strong)UIButton * QQButton;

@end
#define RGBCOLOR(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:1.0]

@implementation ShareActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame WithSourceArray:(NSArray *)array WithIconArray:(NSArray *)iconArray
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShareAcitonViewWithFrame:frame WithSourceArray:array WithIconArray:iconArray];
    }
    return self;
}

- (void)createShareAcitonViewWithFrame:(CGRect)frame WithSourceArray:(NSArray *)arr WithIconArray:(NSArray *)iconArray
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    titleLabel.text = @"分享";
    titleLabel.backgroundColor = RGBCOLOR(242, 245, 247);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    NSInteger count = arr.count;
    NSInteger page = 0;
    page = count/6;
    if ( count%6 != 0) {
        page = page + 1;
    }
    NSInteger row = 1;
    if (count > 3) {
        row = 2;
    }
    CGFloat nH = 30 + 80 *row;
    CGRect nFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, nH);
//    self.height = 30 + 80 * row;
    self.frame = nFrame;
    UIScrollView *bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height)];
    bgScrollerView.backgroundColor = RGBCOLOR(242, 245, 247);
    bgScrollerView.pagingEnabled = YES;
    bgScrollerView.delegate = self;
    bgScrollerView.bounces = NO;
    bgScrollerView.contentSize = CGSizeMake(self.frame.size.width * page, self.frame.size.height);
    [self addSubview:bgScrollerView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width - 100)/2.0, self.frame.size.height - 15, 100, 15)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = page;
    [self addSubview:_pageControl];
    
    float horizeSpace = 0.0f;
    if (count > 3) {
      horizeSpace = (self.frame.size.width - SHAREBUTTONWIDTH *3)/4.0;
    }else
        horizeSpace = (self.frame.size.width - SHAREBUTTONWIDTH *count)/(count + 1);
    float verticalSpace = 10;
    
    for (NSInteger p = 0; p < page; p ++) {
        UIView *multView = [[UIView alloc]initWithFrame:CGRectMake(bgScrollerView.frame.size.width *p, 0, bgScrollerView.frame.size.width, bgScrollerView.frame.size.height)];
        NSLog(@"%@",NSStringFromCGRect(multView.frame));
        multView.backgroundColor = RGBCOLOR(242, 245, 247);
        [bgScrollerView addSubview:multView];
        for (NSInteger i = p*6; i < arr.count; i ++) {
            if (i < (p+1)*6) {
                NSInteger column = (i%6)%3;
                NSInteger r = (i%6)/3;
                ShareActionButtonView *buttonView = [[ShareActionButtonView alloc]initWithFrame:CGRectMake(horizeSpace + (horizeSpace + SHAREBUTTONWIDTH)*column, 5+ (verticalSpace + 70)*r, 60, 70) WithImageName:iconArray[i] WithTitle:arr[i]];
                [buttonView addTarget:self action:@selector(shareToMultPlat:) forControlEvents:UIControlEventTouchUpInside];
                buttonView.tag = i;
                NSLog(@"%@",NSStringFromCGRect(buttonView.frame));
                buttonView.backgroundColor = RGBCOLOR(242, 245, 247);
                [multView addSubview:buttonView];

            }
        }

    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    _pageControl.currentPage = page;
}

- (void)shareToMultPlat:(UIButton *)btn{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(shareToPlatWithIndex:)]) {
        [self actionViewDissmiss];
        [self.delegate shareToPlatWithIndex:btn.tag];
    }
}

- (void)actionViewShow{
    
    
    AppDelegate *delegare = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_bgview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [delegare.window addSubview:_bgview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgviewClick:)];
    tap.numberOfTapsRequired = 1;
    _bgview.userInteractionEnabled = YES;
    [_bgview addGestureRecognizer:tap];
    
    [delegare.window addSubview:self];

    
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.frame.size.height , self.frame.size.width, self.frame.size.height);
    }];
}
- (void)tapBgviewClick:(UITapGestureRecognizer *)tap{
    [self actionViewDissmiss];
}
- (void)actionViewDissmiss{
    AppDelegate  *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.358 animations:^{
         self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height , self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [_bgview removeFromSuperview];
    }];
    
}
@end
