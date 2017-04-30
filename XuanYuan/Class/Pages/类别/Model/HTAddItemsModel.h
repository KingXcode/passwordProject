//
//  HTAddItemsModel.h
//  XuanYuan
//
//  Created by King on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMainItemModel.h"

@interface HTAddItemsModel : NSObject

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * titlePlaceholder;
@property (nonatomic,copy) NSString * text;//textfield文本


@property (nonatomic,strong)infoPassModel *info;
@end
