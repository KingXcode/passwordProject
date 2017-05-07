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
    

    
}

- (IBAction)localAuthor:(id)sender {
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
    BOOL status = [HTTools ht_authorizationStatusForVideo];
    if (!status)
    {
        //无权限
        [self.cameraAuthorBtn setTitle:@"授权" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = YES;
        self.cameraBottomLabel.text = @"为了更好的体验,请到设置->隐私->相机中开启【微密】相机服务.";
        
    }else
    {
        [self.cameraAuthorBtn setTitle:@"已授权" forState:UIControlStateNormal];
        self.cameraAuthorBtn.userInteractionEnabled = NO;
        self.cameraBottomLabel.text = @"已获取相机权限";
        
    }
    
    CLAuthorizationStatus clstatus = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == clstatus || kCLAuthorizationStatusRestricted == clstatus)
    {
        [self.localAuthorBtn setTitle:@"授权" forState:UIControlStateNormal];
        self.localAuthorBtn.userInteractionEnabled = YES;
        self.localBottomLabel.text = @"为了更好的体验,请到设置->隐私->定位服务中开启【微密】定位服务.";

    }else//开启的
    {

        [self.localAuthorBtn setTitle:@"已授权" forState:UIControlStateNormal];
        self.localAuthorBtn.userInteractionEnabled = NO;
        self.localBottomLabel.text = @"已获取定位权限";
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
