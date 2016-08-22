//
//  QRStartScanningVC.m
//  Funny
//
//  Created by yanzhen on 16/1/25.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "QRStartScanningVC.h"
#import "QRScanningViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRStartScanningVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) BOOL is3DTouch;

@end

@implementation QRStartScanningVC

- (instancetype)initWith3DTouch:(BOOL)is3DTouch{
    self = [super init];
    if (self) {
        _is3DTouch = is3DTouch;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imageView.image = [UIImage imageNamedWithFunny:@"pick_bg"];
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 2)];
    _lineImageView.center = CGPointMake(WIDTH/2, _imageView.y);
    _lineImageView.image = [UIImage imageNamedWithFunny:@"line"];
    [self.view addSubview:_lineImageView];
    
    _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(lineMove) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)startScanning{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    AVCaptureVideoPreviewLayer *previewLayer= [AVCaptureVideoPreviewLayer layerWithSession:_session];
    previewLayer.frame = CGRectMake(10, 10, 280, 280);
    //scanImageView.layer.insertSublayer(previewLayer, atIndex: 0);
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.backgroundColor = [UIColor redColor].CGColor;
    [_imageView.layer addSublayer:previewLayer];
    
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if (!_is3DTouch) {
            [_scanVC scanningDone:obj.stringValue];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj.stringValue]];
        }
    }
    
    [_session stopRunning];
    [_timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)lineMove{
    if (!_upOrDown){
        _num += 1;
        _lineImageView.y = _imageView.y + 2.0 * _num;
        if (300 == 2*_num) {
            _upOrDown = YES;
        }
    }else{
        _num -= 1;
        _lineImageView.y = _imageView.y + 2.0 * _num;
        if (0 == 2*_num) {
            _upOrDown = NO;
        }
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [_timer invalidate];
    }];
}


@end
