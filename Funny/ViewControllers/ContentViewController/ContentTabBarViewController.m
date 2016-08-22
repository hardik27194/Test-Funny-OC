//
//  ContentTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ContentTabBarViewController.h"

@interface ContentTabBarViewController ()

@end

@implementation ContentTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *nvc1 = [self nvcWithVCName:@"ContentRecommendViewController" title:@"推荐" imageNameHeader:@"weibo_home"];
    UINavigationController *nvc2 = [self nvcWithVCName:@"ContentTextViewController" title:@"段子" imageNameHeader:@"weibo_compose"];
    UINavigationController *nvc3 = [self nvcWithVCName:@"ContentVideoViewController" title:@"视频" imageNameHeader:@"weibo_music"];
    UINavigationController *nvc4 = [self nvcWithVCName:@"ContentPictureViewController" title:@"图片" imageNameHeader:@"weibo_message"];
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers=viewControllers;
}

@end
