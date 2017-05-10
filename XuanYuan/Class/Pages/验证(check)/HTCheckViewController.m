//
//  HTCheckViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/28.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTCheckViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HTCheckPasswordErrorModel.h"
#import <CoreLocation/CoreLocation.h>

@interface HTCheckViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (nonatomic,copy)NSString *password;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic,strong)NSMutableString *inputString;
@property (nonatomic,assign)NSInteger errorCount;
@property (nonatomic,strong)HTCheckPasswordErrorModel *errorModel;




/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;




/**
 定位服务
 */
@property (nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation HTCheckViewController

-(NSMutableString *)inputString
{
    if (_inputString == nil) {
        _inputString = [NSMutableString string];
    }
    return _inputString;
}

-(NSString *)password
{
    if (_password == nil) {
        _password= [MainConfigManager startPassword];
    }
    return _password;
}

-(HTCheckPasswordErrorModel *)errorModel
{
    if (_errorModel == nil) {
        _errorModel = [[HTCheckPasswordErrorModel alloc]init];
    }
    return _errorModel;
}

- (IBAction)clickedNumberBtn:(UIButton *)sender {
    
    NSString *number = sender.titleLabel.text;
    [self.inputString appendString:number];
    if ([self.passLabel.text isEqualToString:@"验证失败,请重新输入"]) {
        self.passLabel.text = @"";
    }
    self.passLabel.text = [NSString stringWithFormat:@"%@●",self.passLabel.text];
    if (self.inputString.length>=self.password.length) {
        [self check];
    }
    
}

- (IBAction)cancelBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)check
{
    if ([self.inputString isEqualToString:self.password]) {
       
        self.view.userInteractionEnabled = NO;
        
        self.passLabel.text = @"验证成功!";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        
        
    }else
    {
        self.view.userInteractionEnabled = NO;

        [self.inputString setString:@""];
        self.passLabel.text = @"验证失败,请重新输入";
        [HTTools shakeAnnimation:self.passLabel completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
        [HTTools vibrate];
        
        BOOL isAllow = [MainConfigManager isAllowInvadeRecord];
        AVAuthorizationStatus auth = [HTTools ht_authorizationStatusForVideo];
        
        if (isAllow&&(auth == AVAuthorizationStatusAuthorized)) {
            [self invadeRecord];
            [self initLocation];

        }
        self.errorCount++;
    }
}

-(void)invadeRecord
{
    NSInteger checkCount = 2;

    if (self.errorCount < checkCount) {
        
        //安全范围   不处理
        
    }else if (self.errorCount == checkCount){
        
        //忍耐范围   准备处理
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self initAVCaptureSession];
            
        });
        
    }else
    {
        //不忍耐     拍照定位处理
        [self shutterCameraHandler:^{
            self.errorModel.errorCount = self.errorCount;
            [self.errorModel saveObject];
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorCount = 0;
    self.showLabel.font = [UIFont boldSystemFontOfSize:26];

    
    [self.cancelButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneInForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
}

-(void)appHasGoneInForeground:(NSNotification *)noti
{
    [self enableTouchID];
}



-(void)viewDidAppear:(BOOL)animated
{
    [self enableTouchID];
}


-(void)enableTouchID
{
    
    [HTTools enableTouchIDCheck:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
    
}

-(void)setImage:(UIImageView *)image
{
    _image = image;
    
    [self.view insertSubview:_image atIndex:0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPreset640x480;
    }
    return _session;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}


- (void)initAVCaptureSession{
    
    
    NSError *error;
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    self.previewLayer.frame = CGRectMake(0, 0, 1, 1);

    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.view.layer addSublayer:self.previewLayer];

    });
    
}

- (void) shutterCameraHandler:(void (^)())handler
{
    if (self.session) {
        [self.session startRunning];
    }
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    [self eliminateVoice];
    __weak typeof(self) __self = self;
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage * image = [UIImage imageWithData:imageData];

        
        NSString *encodedImageStr = [HTCheckPasswordErrorModel imageToString:image];
        __self.errorModel.imageString = encodedImageStr;
        
        if (handler) {
            handler();
        }
    }];
}


/**
 消除声音
 */
-(void)eliminateVoice
{
    static SystemSoundID soundID = 0;
    if (soundID == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"photoShutter2" ofType:@"caf"];
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    }
    AudioServicesPlaySystemSound(soundID);
}

-(void)initLocation
{
    //初始化定位管理器
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
    }
    //设置代理
    self.locationManager.delegate = self;
    //定位精准度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //横向移动多少距离后更新位置信息
    self.locationManager.distanceFilter = 10;
    //ios8以后需要获取定位权限
    //有两个方法，取决于你的定位使用情况 一个是requestAlwaysAuthorization（始终允许获取定位信息），一个是requestWhenInUseAuthorization（使用期间允许获取定位信息）
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.firstObject;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0){
            //获取到编译出的地标（CLPlacemark是一个地标类，封装了经纬度，国家，城市等地址信息）
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            //当前地址
            NSLog(@"placemark.name = %@",placemark.name);
            
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            
            self.errorModel.location = [NSString stringWithFormat:@"%@%@",city,placemark.name];
        }
        
    }];
    
    [manager stopUpdatingLocation];
}

//定位失败时的回调
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSString *errMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errMsg = @"获取位置信息失败";
    }
    self.errorModel.location = errMsg;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    if (self.session) {
        
        [self.session startRunning];
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    if (self.session) {
        
        [self.session stopRunning];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
