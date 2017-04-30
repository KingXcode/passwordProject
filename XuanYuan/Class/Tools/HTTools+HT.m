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
    UIImageWriteToSavedPhotosAlbum([self captureScreen], nil, nil, nil);
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





@end
