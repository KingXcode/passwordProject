//
//  HTTools+SafariService.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"
#import <SafariServices/SafariServices.h>


@interface HTTools (SafariService)

+(SFSafariViewController *)openSafariServiceWithUrl:(NSURL *)url byController:(UIViewController *)controller;

@end
