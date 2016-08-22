//
//  GifShowTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/10.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "GifShowTabBarViewController.h"

@interface GifShowTabBarViewController ()

@end

@implementation GifShowTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *nvc1 = [self nvcWithVCName:@"GifShowViewController" title:@"快手" imageNameHeader:@"weibo_music"];
    UINavigationController *nvc2 = [self nvcWithVCName:@"WhatSomePictureViewController" title:@"图片" imageNameHeader:@"weibo_favorite"];
    NSArray *viewControllers=@[nvc1,nvc2];
    self.viewControllers=viewControllers;
}


@end
