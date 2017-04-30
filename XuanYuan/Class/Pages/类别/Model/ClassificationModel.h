//
//  ClassificationModel.h
//  XuanYuan
//
//  Created by King on 2017/4/24.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTMainItemModel.h"

@interface ClassificationModel : HTMainItemModel

@property (nonatomic,assign)BOOL selectState;       //选中状态

@property (nonatomic,assign,readonly)CGFloat cellHeight;     //cell的高度

@end
