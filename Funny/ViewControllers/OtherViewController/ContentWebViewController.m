//
//  ContentWebViewController.m
//  Funny
//
//  Created by yanzhen on 16/6/28.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "ContentWebViewController.h"

@interface ContentWebViewController ()

@end

@implementation ContentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - super
- (NSString *)jsString{
    NSMutableString *js = [NSMutableString string];
    //删除顶部和底部的bar
    [js appendString:@"var openNow = document.getElementsByClassName('open download J-download J-app-download-link')[0];"];
    [js appendString:@"var openNow1 = document.getElementsByClassName('open download J-download J-app-download-link')[1];"];
    
    [js appendString:@"var topBar = openNow.parentNode;"];
    [js appendString:@"topBar.parentNode.removeChild(topBar);"];
    
    [js appendString:@"var bottomBar = openNow1.parentNode;"];
    [js appendString:@"bottomBar.parentNode.removeChild(bottomBar);"];
    return js;
}

@end
