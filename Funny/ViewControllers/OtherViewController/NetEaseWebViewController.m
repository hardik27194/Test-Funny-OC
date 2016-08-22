//
//  NetEaseWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/6/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "NetEaseWebViewController.h"

@interface NetEaseWebViewController ()

@end

@implementation NetEaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - super
- (NSString *)jsString{
    NSMutableString *js = [NSMutableString string];
    // 删除顶部
    [js appendString:@"var yzTopbar = document.getElementsByClassName('topbar')[0];"];
    [js appendString:@"yzTopbar.parentNode.removeChild(yzTopbar);"];
    // 删除广告
    [js appendString:@"var box = document.getElementsByClassName('a_adtemp a_topad js-topad')[0];"];
    [js appendString:@"box.parentNode.removeChild(box);"];
    //
    [js appendString:@"var buyNow = document.getElementsByClassName('more_client more-client')[0];"];
    [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
    //广告
    [js appendString:@"var yzTB = document.getElementsByClassName('a_adtemp a_tbad js-tbad')[0];"];
    [js appendString:@"yzTB.parentNode.removeChild(yzTB);"];
    return js;
}
@end
