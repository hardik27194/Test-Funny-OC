//
//  TodayViewController.m
//  Today
//
//  Created by yanzhen on 16/10/12.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <YZIPhoneDevice/YZIPhoneDevice.h>
#import "ExtensionButton.h"
#import "YZCircleView.h"
#import <FunnyKit/FunnyKit.h>

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, strong) YZNetwork *network;
@property (nonatomic, strong) YZCPU *cpu;
@property (nonatomic, strong) YZCircleView *CPUView;
@property (nonatomic, strong) YZCircleView *memoryView;
@property (nonatomic, strong) YZCircleView *netWorkView;
@property (nonatomic, weak)   NSTimer *timer;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#pragma mark - 1
    //可以设置是否支持折叠
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;

#pragma mark - App Group
#pragma mark - Framework
//    //数据共享方式之一
    //仅做测试使用
    FunnyDeviceTest *device = [[FunnyDeviceTest alloc] init];
    device.title = @"Y&Z Area";
    
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.v2tech.BCYZ"];
    [ud setValue:device.title forKey:@"BCYZ"];
    [ud synchronize];
//
//    //数据共享方式之二
//    NSURL *url = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.v2tech.BCYZ"];
//    NSString *path = [url.path stringByAppendingPathComponent:@"gif.png"];
//    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"gifShow"]);
//    [data writeToFile:path atomically:YES];
    
    [self configUI];
}

#ifdef __IPHONE_10_0
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        //高度小于110，没有效果 ？？？
        self.preferredContentSize = CGSizeMake(0, 110);
    }else{
        //高度必须大于110
        self.preferredContentSize = CGSizeMake(0, 220);
    }
}

#else

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

#endif

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    //不刷新
    completionHandler(NCUpdateResultNewData);
    //completionHandler(NCUpdateResultNewData);
}
#pragma mark - UI
- (void)configUI{
    
    NSArray *titles = @[@"内涵段子",@"快手",@"记事本",@"二维码"];
    NSArray *images = @[@"content",@"gifShow",@"note",@"QR"];
    
    CGFloat space = 10.0;
#pragma mark - 2
    //获得有效显示的size----10.0
    CGSize maximumSize = [self.extensionContext widgetMaximumSizeForDisplayMode:NCWidgetDisplayModeExpanded];
    CGFloat btnWidth = (maximumSize.width - 5 * space) / 4;
    CGFloat btnHeight = maximumSize.height - 20;
    for (int i = 0; i < 4; i++) {
        ExtensionButton *btn = [[ExtensionButton alloc] initWithFrame:CGRectMake(space + (btnWidth + space) * i, 10, btnWidth, btnHeight)];
        btn.tag = 100 + i;
        UIImage *image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(extensionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    CGFloat bottomSpace = (maximumSize.width - 90 * 3) / 4.0;
    CGFloat x1 = bottomSpace;
    _CPUView = [[YZCircleView alloc] initWithRadius:85/2 frame:CGRectMake(x1, 120, 90, 90)];
    _CPUView.title = @"CPU";
    [self.view addSubview:_CPUView];
    _cpu = [[YZCPU alloc] init];
    __weak typeof(self) weakSelf = self;
    [_cpu startMonitorCPUUsageWithTimeInterval:1.0 usage:^(CGFloat usage) {
        weakSelf.CPUView.subTitle = [NSString stringWithFormat:@"%.1f%%",usage * 100];
        weakSelf.CPUView.progress = usage;
    }];
    
    x1 = bottomSpace + (bottomSpace + 90);
    _memoryView = [[YZCircleView alloc] initWithRadius:85/2 frame:CGRectMake(x1, 120, 90, 90)];
    _memoryView.titleFontSize = 13.0;
    _memoryView.subTitleFontSize = 13.0;
    _memoryView.title = @"空间剩余";
    long long totalSize = [YZDevice getTotalDiskSize];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        long long availableSize = [YZDevice getAvailableDiskSize];
        weakSelf.memoryView.subTitle = [NSString stringWithFormat:@"%.1fG/%.1fG",availableSize / 1024.0 / 1024 / 1024,totalSize / 1024.0 / 1024 / 1024];
        weakSelf.memoryView.progress = 1 - availableSize / (totalSize * 1.0);
    }];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [self.view addSubview:_memoryView];
    
    x1 = bottomSpace + (bottomSpace + 90) * 2;
    _netWorkView = [[YZCircleView alloc] initWithRadius:85/2 frame:CGRectMake(x1, 120, 90, 90)];
    _netWorkView.title = @"无网络";
    [self.view addSubview:_netWorkView];
    
    _network = [[YZNetwork alloc] init];
    [_network getCurrentNetSpeed:^(YZNetWorkFluxStatistics *netWorkFlux) {
        NSArray *titles = @[@"无网络",@"Wifi",@"4G",@"3G",@"2G"];
        weakSelf.netWorkView.title = titles[netWorkFlux.netStatus];
        weakSelf.netWorkView.subTitle = [weakSelf stringFromBytes:netWorkFlux.received];
    }];
}

- (NSString *)stringFromBytes:(float)received{
    static const uint64_t KB  = 1024;
    static const uint64_t MB  = KB * 1024;
    static const uint64_t GB  = MB * 1024;
    NSString *speed = @"0B/s";
    if (received >= GB) {
        speed = [NSString stringWithFormat:@"%.1fG/s",received / GB];
    }else if (received >= MB){
        speed = [NSString stringWithFormat:@"%.1fM/s",received / MB];
    }else if (received >= KB){
        speed = [NSString stringWithFormat:@"%.1fKB/s",received / KB];
    }else{
        speed = [NSString stringWithFormat:@"%.0fB/s",received];
    }
    return speed;
}


- (void)extensionButtonAction:(ExtensionButton *)btn{
    //设置主干工程 URL Schemes
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"BCYZ://%ld",(long)btn.tag]];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
    }];
}

-(void)dealloc{
    [_timer invalidate];
    [_cpu stopMonitorCPUUsage];
    [_network stopMonitorNetWork];
}
@end
