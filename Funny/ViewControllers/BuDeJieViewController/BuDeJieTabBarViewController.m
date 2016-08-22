//
//  BuDeJieTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/12.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "BuDeJieTabBarViewController.h"

@interface BuDeJieTabBarViewController ()

@end

@implementation BuDeJieTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationController *nvc1=[self nvcWithVCName:@"BuDeJieTextViewController" title:@"段子" imageNameHeader:@"weibo_compose"];
    UINavigationController *nvc2=[self nvcWithVCName:@"BuDeJieVideoViewController" title:@"视频" imageNameHeader:@"weibo_music"];
    UINavigationController *nvc3=[self nvcWithVCName:@"BuDeJiePictureViewController" title:@"图片" imageNameHeader:@"weibo_message"];
    UINavigationController *nvc4=[self nvcWithVCName:@"BuDeJieRankViewController" title:@"排行" imageNameHeader:@"weibo_favorite"];
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers=viewControllers;
}
@end
