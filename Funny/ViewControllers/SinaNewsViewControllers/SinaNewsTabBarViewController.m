//
//  SinaNewsTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaNewsTabBarViewController.h"
#import "SinaNewsSuperViewController.h"

@interface SinaNewsTabBarViewController ()

@end

@implementation SinaNewsTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController* (^block)(NSArray <NSString *>*array) = ^(NSArray <NSString *>*array){
        SinaNewsSuperViewController *vc = [[NSClassFromString(array[0]) alloc] init];
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = array[1];
        vc.titleName = array[3];
        NSString *uImageName = [array[2] stringByAppendingString:@"_u"];
        NSString *sImageName = [array[2] stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    UINavigationController *nvc1 = block(@[@"SinaNewsSuperViewController",@"头条",@"weibo_home",@"toutiao"]);
    UINavigationController *nvc2 = block(@[@"SinaRecommendViewController",@"推荐",@"weibo_compose",@"tuijian"]);
    UINavigationController *nvc3 = block(@[@"SinaNewsSuperViewController",@"娱乐",@"weibo_music",@"ent"]);
    UINavigationController *nvc4 = block(@[@"SinaNewsSuperViewController",@"搞笑",@"weibo_favorite",@"funny"]);
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers=viewControllers;
}
@end
