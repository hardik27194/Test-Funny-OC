//
//  TodayViewController.m
//  Today
//
//  Created by yanzhen on 16/10/12.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "ExtensionButton.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#pragma mark - 1
    //可以设置是否支持折叠
    //    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    
    [self configUI];
}

#ifdef __IPHONE_10_0
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        //高度小于110，没有效果 ？？？
        self.preferredContentSize = CGSizeMake(0, 80);
    }else{
        //高度必须大于110
        self.preferredContentSize = CGSizeMake(0, 120);
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
    completionHandler(NCUpdateResultNoData);
    //completionHandler(NCUpdateResultNewData);
}
#pragma mark - UI
- (void)configUI{
    
    NSArray *titles = @[@"内涵段子",@"快手",@"记事本",@"二维码"];
    NSArray *images = @[@"content",@"gifShow",@"note",@"QR"];
    
    CGFloat space = 10.0;
#pragma mark - 2
    //获得有效显示的size----10.0
    CGSize maximumSize = [self.extensionContext widgetMaximumSizeForDisplayMode:NCWidgetDisplayModeCompact];
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
}

- (void)extensionButtonAction:(ExtensionButton *)btn{
    //设置主干工程 URL Schemes
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"BCYZ://%ld",btn.tag]];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
    }];
}

@end
