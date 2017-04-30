//
//  UIView+AddClick.h
//  pangu
//
//  Created by 谢翰然 on 16/12/16.
//  Copyright © 2016年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddClick)

-(void)addClickBlock:(void(^)(id obj))clickAction;

@end
