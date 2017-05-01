//
//  HTSelectIconType.h
//  XuanYuan
//
//  Created by King on 2017/5/1.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTSelectIconTypeView : UIView
@property (nonatomic,assign) NSInteger typeIcon;
@property (nonatomic,copy) void (^didselectIcon)(NSString *type);

@end
