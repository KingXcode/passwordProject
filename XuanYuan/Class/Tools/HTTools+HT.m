//
//  HTTools+HT.m
//  XuanYuan
//
//  Created by King on 2017/4/25.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+HT.h"
#import <AudioToolbox/AudioToolbox.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "sys/utsname.h"


@implementation HTTools (HT)

+(void)enableTouchIDCheck:(void(^)(BOOL success, NSError *error))reply
{
    BOOL isStartTouchID = [MainConfigManager isOpenTouchID];
    if (isStartTouchID == NO) {
        return;
    }
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

//分词 带标点
+ (NSArray *)stringTokenizerWithWord:(NSString *)word
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)word,       CFRangeMake(0, word.length),kCFStringTokenizerUnitWordBoundary,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[word substringWithRange:NSMakeRange(range.location, range.length)];
       
        if (![keyWord isEqualToString:@" "]) {
            [keyWords addObject:keyWord];
        }
        
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}

//分词 不带标点
+ (NSArray *)notDotStringTokenizerWithWord:(NSString *)word
{
    NSMutableArray *keyWords=[NSMutableArray new];
    CFStringTokenizerRef ref=CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)word,       CFRangeMake(0, word.length),kCFStringTokenizerUnitWord,NULL);
    CFRange range;
    CFStringTokenizerAdvanceToNextToken(ref);
    range=CFStringTokenizerGetCurrentTokenRange(ref);
    NSString *keyWord;
    while (range.length>0)
    {
        keyWord=[word substringWithRange:NSMakeRange(range.location, range.length)];
        [keyWords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range=CFStringTokenizerGetCurrentTokenRange(ref);
    }
    return keyWords;
}


+ (UIImage *) captureScreen {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [self convertViewToImage:keyWindow];
    
}

+ (void)saveScreenshotToPhotosAlbum:(UIView *)view
{
    UIImageWriteToSavedPhotosAlbum([self convertViewToImage:view], nil, nil, nil);
}


+(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame
{
    return  [self gaussianBlurWithFrame:frame andStyle:UIBlurEffectStyleDark];
}

+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame andStyle:(UIBlurEffectStyle)style
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

+(UIImageView *)gaussianBlurWithMainRootView
{
    UIImage *image = [self captureScreen];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = MainRootViewController.view.bounds;
    [imageView addSubview:[self gaussianBlurWithFrame:imageView.bounds andStyle:UIBlurEffectStyleExtraLight]];
    return imageView;
}



+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {

    return [self sizeOfString:string font:font width:width].height;
}

+(CGSize)sizeOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size;
}


+ (CATransition *)createTransitionAnimationWithType:(NSString *)type direction:(NSString *)direction time:(double)time
{
    //切换之前添加动画效果
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    //设置动画的类型:
    animation.type = type;
    //设置动画的方向
    animation.subtype = direction;
    //设置动画的持续时间
    animation.duration = time;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}

+(void)TransformView:(UIView *)view
{
    CGFloat rotationAngleDegrees = 0;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(view.frame.size.width, 0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    
    view.layer.transform = transform;
    view.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.4f animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];
}

+(void)shakeAnnimation:(UIView *)view completion:(void (^)(BOOL finished))completion
{
    
    [UIView animateWithDuration:0.05f animations:^{
        
        view.layer.transform = CATransform3DTranslate(view.layer.transform, 10, 0.0, 0.0);
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05f animations:^{
            
            view.layer.transform = CATransform3DTranslate(view.layer.transform, -10, 0.0, 0.0);
            
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.05f animations:^{
                
                view.layer.transform = CATransform3DTranslate(view.layer.transform, 10, 0.0, 0.0);
                
            }completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.05f animations:^{
                    
                    view.layer.transform = CATransform3DTranslate(view.layer.transform, -10, 0.0, 0.0);
                    
                }completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.05f animations:^{
                        
                        view.layer.transform = CATransform3DTranslate(view.layer.transform, 10, 0.0, 0.0);
                        
                    }completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.05f animations:^{
                            
                            view.layer.transform = CATransform3DIdentity;
                            
                        } completion:^(BOOL finished) {
                            if (completion) {
                                completion(finished);
                            }
                        }];
                        
                    }];
                }];
                
            }];
            
        }];
        
    }];
    
}



+(void)CATransform3DScaleView:(UIView *)view
{
    [self CATransform3DScaleView:view Duration:0.4f];
}



+(void)CATransform3DScaleView:(UIView *)view Duration:(NSTimeInterval)duration
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 0, 0, 1);
    view.layer.transform = transform;

    [UIView animateWithDuration:duration animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];
}






+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
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




@end
