//
//  HTTools+Systerm.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

/*!
 注意：
 最低支持iOS8
 iOS 10 系统下需要请求相关权限，iOS 10 干掉了所有系统设置的 URL Scheme，这意味着你再也不可能直接跳转到系统设置页面（比如 WiFi、蜂窝数据、定位等）。
 iOS 10 不支持,任意方法都只会跳转到设置界面
 ios 10 系统，其他权限具体设置如下：
 
 麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
 相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
 相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
 通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
 蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
 语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
 日历权限：Privacy - Calendars Usage Description 是否允许此App使用日历？
 定位权限：Privacy - Location When In Use Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
 定位权限: Privacy - Location Always Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
 
 
 */

#import "HTTools+Systerm.h"


#import <mach/mach.h>
#import "sys/utsname.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AudioToolbox/AudioToolbox.h>

#define HT_OpenUrl(urlStr) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]]

@implementation HTTools (Systerm)




+(AVAuthorizationStatus)ht_authorizationStatusForVideo
{
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    
    return AVstatus;
}



/**
 系统版本
 */
+(NSString *)phoneVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 *  设备版本
 *
 *  @return e.g. iPhone 5S
 */
+ (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

+ (float)cpuUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if(kr != KERN_SUCCESS)
    {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0;
    
    basic_info = (task_basic_info_t)tinfo;
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if(kr != KERN_SUCCESS)
    {
        return -1;
    }
    if(thread_count > 0)
    {
        stat_thread += thread_count;
    }
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for(j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if(kr != KERN_SUCCESS)
        {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if(!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
        
    }
    
    return tot_cpu;
}

/*!
 *  跳转系统通知
 */
+ (void)gotoSystermSettings
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        HT_OpenUrl(UIApplicationOpenSettingsURLString);
    }
}


/*!
 *  跳转Safari浏览器
 */
+ (void)gotoSafariBrowserWithURL:(NSString *)url
{
    if(![url hasPrefix:@"http"])
    {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    
    if ([self ht_IsUrl:url])
    {
        /*! 跳转系统通知 */
        NSURL *newUrl = [NSURL URLWithString:url];
        if ([[UIApplication sharedApplication]canOpenURL:newUrl]) {
            
            if ([[UIDevice currentDevice] systemVersion].floatValue>=10) {
                
                [[UIApplication sharedApplication]openURL:newUrl options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
                [[UIApplication sharedApplication]openURL:newUrl];
            }
        }
        
    }
    else
    {
        NSLog(@"url错误，请重新输入！");
    }
    
}

+ (void)ht_callPhone:(NSString *)phone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


+(void)enableTouchIDCheck:(void(^)(BOOL success, NSError *error))reply
{
    LAContext *context = [LAContext new];
    context.localizedFallbackTitle = @"忘记密码";
    
    NSError *error = nil;
    BOOL canEvaluate = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                            error:&error];
    if (canEvaluate)
    {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    
                    if (reply) {
                        reply(success,error);
                    }
                    
                }];
    }else{
        
        if (reply) {
            reply(NO,error);
        }
        
    }
}

+(BOOL)canOpenTouchID
{
    LAContext *context = [LAContext new];
    BOOL canEvaluate = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                            error:nil];
    return canEvaluate;
}


+(void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}

@end
