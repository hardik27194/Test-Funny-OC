//
//  NetEaseTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NetEaseTabBarViewController.h"
#import "NetEaseSuperViewController.h"
#import "NetEaseMacro.h"

@interface NetEaseTabBarViewController ()

@end

@implementation NetEaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController* (^block)(NSArray <NSString *>*array) = ^(NSArray <NSString *>*array){
        NetEaseSuperViewController *vc = [[NSClassFromString(array[0]) alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.defaultURL = array[3];
        vc.pushURL = array[4];
        vc.key = array[5];
        vc.title = array[1];
        NSString *uImageName = [array[2] stringByAppendingString:@"_u"];
        NSString *sImageName = [array[2] stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    
    UINavigationController *nvc1 = block(@[@"NetEaseHeadLineViewController",@"头条",@"weibo_home",NetEaseHeadLineDefaultURL,NetEaseHeadLinePushURL,@"T1348647909107"]);
    UINavigationController *nvc2 = block(@[@"NetEaseSuperViewController",@"原创",@"weibo_compose",NetEaseOriginalDefaultURL,NetEaseOriginalPushURL,@"T1370583240249"]);
    UINavigationController *nvc3 = block(@[@"NetEaseSuperViewController",@"娱乐",@"weibo_message",NetEasePlayDefaultURL,NetEasePlayPushURL,@"T1348648517839"]);
    UINavigationController *nvc4 = block(@[@"NetEaseContentViewController",@"段子",@"weibo_music",NetEaseContentDefaultURL,NetEaseContentPushURL,@""]);
    UINavigationController *nvc5 = block(@[@"NetEaseSuperViewController",@"体育子",@"weibo_favorite",NetEaseSportDefaultURL,NetEaseSportPushURL,@"T1348649079062"]);
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4,nvc5];
    self.viewControllers=viewControllers;
}

@end
