//
//  HTAccessView.m
//  XuanYuan
//
//  Created by King on 2017/5/5.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTAccessView.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>



@interface HTAccessView ()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *manager;
@end


@implementation HTAccessView

- (IBAction)mainSwitch:(UISwitch *)sender {
    
    self.cameraAuthorBtn.enabled = sender.on;
    self.localAuthorBtn.enabled = sender.on;
    [MainConfigManager isAllowInvadeRecord:sender.on];
}


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (IBAction)cameraAuthor:(UIButton *)sender {
    
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setAuthorizationStatusVideo];
            
        });
        
        
    }];
    
    
}

- (IBAction)localAuthor:(id)sender {
    
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];//使用的时候获取定位信息
    manager.delegate = self;
    self.manager = manager;
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    [self setLocalAuthorBtnStatus:status];
    
}











+(instancetype)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HTAccessView" owner:self options:nil] lastObject];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    [self setUI];
    
    [self setAuthorizationStatus];
    
    
}

-(void)setAuthorizationStatus
{
    
    [self setAuthorizationStatusVideo];
    [self setAuthorizationStatusLocal];
    
}


-(void)setAuthorizationStatusVideo
{
    AVAuthorizationStatus status = [HTTools ht_authorizationStatusForVideo];
    if (status == AVAuthorizationStatusNotDetermined)
    {
        [self.cameraAuthorBtn setTitle:@"授权" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = YES;
        self.cameraBottomLabel.text = @"为了更好的体验,请到设置->隐私->相机中开启【微密】相机服务.";
        
    }else if (status == AVAuthorizationStatusRestricted)
    {
        //无权限
        [self.cameraAuthorBtn setTitle:@"受限制" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = NO;
        self.cameraBottomLabel.text = @"为了更好的体验,请到设置->隐私->相机中开启【微密】相机服务.";
    }
    else if (status == AVAuthorizationStatusDenied)
    {
        //无权限
        [self.cameraAuthorBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = NO;
        self.cameraBottomLabel.text = @"为了更好的体验,请到设置->隐私->相机中开启【微密】相机服务.";
    }
    else if(status == AVAuthorizationStatusAuthorized)
    {
        [self.cameraAuthorBtn setTitle:@"已授权" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = NO;
        self.cameraBottomLabel.text = @"已获取相机权限";
    }
}

-(void)setAuthorizationStatusLocal
{
    
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation)
    {
        [self.localAuthorBtn setTitle:@"已禁用" forState:UIControlStateNormal];
        self.localAuthorBtn.userInteractionEnabled = NO;
        self.localBottomLabel.text = @"为了更好的体验,请开启定位服务.";
    }
    else
    {
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        [self setLocalAuthorBtnStatus:CLstatus];
    }
}

-(void)setLocalAuthorBtnStatus:(CLAuthorizationStatus)CLstatus
{
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            [self.localAuthorBtn setTitle:@"已授权" forState:UIControlStateNormal];
            self.localAuthorBtn.userInteractionEnabled = NO;
            self.localBottomLabel.text = @"已获取定位权限";
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            [self.localAuthorBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
            self.localAuthorBtn.userInteractionEnabled = NO;
            self.localBottomLabel.text = @"为了更好的体验,请到设置->隐私->定位服务中开启【微密】定位服务.";
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            [self.localAuthorBtn setTitle:@"授权" forState:UIControlStateNormal];
            self.localAuthorBtn.userInteractionEnabled = YES;
            self.localBottomLabel.text = @"为了更好的体验,请到设置->隐私->定位服务中开启【微密】定位服务.";
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            [self.localAuthorBtn setTitle:@"受限制" forState:UIControlStateNormal];
            self.localAuthorBtn.userInteractionEnabled = NO;
            self.localBottomLabel.text = @"为了更好的体验,请到设置->隐私->定位服务中开启【微密】定位服务.";
        }
            break;
        default:
            break;
    }
}







-(void)setUI
{
    [self.cameraAuthorBtn ht_setCornerRadius:4];
    [self.cameraAuthorBtn ht_setBorderWidth:1 Color:[UIColor darkGrayColor]];
    [self.cameraAuthorBtn setBackgroundImage:[HTTools ht_createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    
    [self.localAuthorBtn ht_setCornerRadius:4];
    [self.localAuthorBtn ht_setBorderWidth:1 Color:[UIColor darkGrayColor]];
    [self.localAuthorBtn setBackgroundImage:[HTTools ht_createImageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    
    
    BOOL isAllow = [MainConfigManager isAllowInvadeRecord];
    self.mainSwitch.on = isAllow;
    self.cameraAuthorBtn.enabled = isAllow;
    self.localAuthorBtn.enabled = isAllow;
}


@end
