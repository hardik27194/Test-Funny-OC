//
//  WalfareTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfareTabBarViewController.h"
#import "WalfareSuperViewController.h"
#import "WalfareMacro.h"

@interface WalfareTabBarViewController ()

@end

@implementation WalfareTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController* (^block)(NSArray <NSString *>*array) = ^(NSArray <NSString *>*array){
        WalfareSuperViewController *vc = [[NSClassFromString(array[0]) alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = array[1];
        vc.defaultURL = array[3];
        vc.defaultFootURL = WalfareDefaultFootURL;
        vc.defaultPushMiddleURL = WalfarePushDefaultMiddleURL;
        vc.pullHeadURL = array[4];
        vc.pushHeadURL = array[5];
        NSString *uImageName = [array[2] stringByAppendingString:@"_u"];
        NSString *sImageName = [array[2] stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    UINavigationController *nvc1 = block(@[@"WalfareTextViewController",@"段子",@"weibo_compose",WalfareTextDefaultURL,WalfareTextPullHeadURL,WalfareTextPushHeadURL]);
    UINavigationController *nvc2 = block(@[@"WalfarePictureViewController",@"图片",@"weibo_message",WalfarePictureDefaultURL,WalfarePicturePullHeadURL,WalfarePicturePushHeadURL]);
    UINavigationController *nvc3 = block(@[@"WalfareVideoViewController",@"视频",@"weibo_music",WalfareVideoDefaultURL,WalfareVideoPullHeadURL,WalfareVideoPushHeadURL]);
    UINavigationController *nvc4 = block(@[@"WalfareGirlViewController",@"美女",@"weibo_favorite",WalfareGirlDefaultURL,WalfareGirlPullHeadURL,WalfareGirlPushHeadURL]);
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers=viewControllers;
}

@end
