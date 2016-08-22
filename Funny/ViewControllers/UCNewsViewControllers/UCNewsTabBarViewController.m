//
//  UCNewsTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/19.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "UCNewsTabBarViewController.h"
#import "UCNewsSuperViewController.h"
#import "UCNewsMacro.h"

@interface UCNewsTabBarViewController ()

@end

@implementation UCNewsTabBarViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController* (^block)(NSArray <NSString *>*array) = ^(NSArray <NSString *>*array){
        UCNewsSuperViewController *vc = [[UCNewsSuperViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.UCNewsHeadURL = array[2];
        vc.UCNewsMiddleURL = array[3];
        vc.UCNewsFootURL = array[4];
        vc.title = array[0];
        NSString *uImageName = [array[1] stringByAppendingString:@"_u"];
        NSString *sImageName = [array[1] stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    UINavigationController *nvc1 = block(@[@"推荐",@"weibo_home",UCNewsRecommendHeadURL,UCNewsRecommendMiddleURL,UCNewsRecommendFootURL]);
    UINavigationController *nvc2 = block(@[@"NBA",@"weibo_compose",UCNewsNBAHeadURL,UCNewsNBAMiddleURL,UCNewsNBAFootURL]);
    UINavigationController *nvc3 = block(@[@"娱乐",@"weibo_music",UCNewsPlayHeadURL,UCNewsPlayMiddleURL,UCNewsPlayFootURL]);
    UINavigationController *nvc4 = block(@[@"社会",@"weibo_message",UCNewsSocialHeadURL,UCNewsSocialMiddleURL,UCNewsSocialFootURL]);
    UINavigationController *nvc5 = block(@[@"搞笑",@"weibo_favorite",UCNewsFunnyHeadURL,UCNewsFunnyMiddleURL,UCNewsFunnyFootURL]);
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4,nvc5];
    self.viewControllers = viewControllers;
}
@end
