//
//  HTColorManager.h
//  XuanYuan
//
//  Created by King on 2017/5/2.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTColorManager : NSObject

+(instancetype)sharedcolorManager;

-(UIColor *)mainRGB;
-(UIColor *)mainTextColor;
-(UIColor *)mainTextWhiteColor;
-(UIColor *)mainCollectColor;
-(UIColor *)mainTableViewBackgroundColor;
-(UIColor *)mainCoverColor;
@end
