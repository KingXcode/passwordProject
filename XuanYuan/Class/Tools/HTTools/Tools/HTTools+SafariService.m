//
//  HTTools+SafariService.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+SafariService.h"

@implementation HTTools (SafariService)
+(SFSafariViewController *)openSafariServiceWithUrl:(NSURL *)url byController:(UIViewController *)controller
{
    // [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending||[[[UIDevice currentDevice] systemVersion]isEqualToString:@"10.3.1"]
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if (version.integerValue>=10) {
        
        SFSafariViewController *vc = [[SFSafariViewController alloc]initWithURL:url];
        [controller presentViewController:vc animated:YES completion:nil];
        return vc;
    }else
    {
        [self gotoSafariBrowserWithURL:url.absoluteString];
        return nil;
    }
    
}
@end
