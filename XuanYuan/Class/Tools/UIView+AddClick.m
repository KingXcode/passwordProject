//
//  UIView+AddClick.m
//  pangu
//
//  Created by 谢翰然 on 16/12/16.
//  Copyright © 2016年 zby. All rights reserved.
//

#import "UIView+AddClick.h"
#import <objc/message.h>

@interface UIView()

@property (nonatomic,copy) void(^clickAction)(id);

@end

@implementation UIView (AddHRClick)

- (void)setClickAction:(void (^)(id))clickAction{
    objc_setAssociatedObject(self, @"AddClick", clickAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(id))clickAction{
    return objc_getAssociatedObject(self, @"AddClick");
}

-(void)addClickBlock:(void (^)(id))clickAction{
    self.clickAction = clickAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

-(void)tap{
    if (self.clickAction) {
        self.clickAction(self);
    }
}

@end
