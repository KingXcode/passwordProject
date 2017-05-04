//
//  ShareActionView.h
//  CheckIn
//
//  Created by kule on 16/1/13.
//  Copyright © 2016年 zhiye. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareActionViewDelegate <NSObject>

- (void)shareToPlatWithIndex:(NSInteger)index;

@end

@interface ShareActionButtonView: UIButton
@end

@interface ShareActionView : UIView<UIScrollViewDelegate>
{
    UIPageControl *_pageControl ;
}
@property (nonatomic,assign)id<ShareActionViewDelegate>delegate;
@property (nonatomic,strong)UIView *bgview;

- (id)initWithFrame:(CGRect)frame
    WithSourceArray:(NSArray *)array
      WithIconArray:(NSArray *)iconArray;

- (void)actionViewShow;
- (void)actionViewDissmiss;
@end
