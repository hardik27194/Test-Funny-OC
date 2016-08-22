//
//  SinaVideoTabBartViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaVideoTabBartViewController.h"
#import "SinaVideoSuperViewController.h"

@interface SinaVideoTabBartViewController ()

@end

@implementation SinaVideoTabBartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController* (^block)(NSArray <NSString *>*array) = ^(NSArray <NSString *>*array){
        SinaVideoSuperViewController *vc = [[SinaVideoSuperViewController alloc] init];
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = array[0];
        vc.titleName = array[2];
        NSString *uImageName = [array[1] stringByAppendingString:@"_u"];
        NSString *sImageName = [array[1] stringByAppendingString:@"_s"];
        UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
        UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
        [nvc.tabBarItem setImage:unSelectImage];
        [nvc.tabBarItem setSelectedImage:selectImage];
        return nvc;
    };
    
    UINavigationController *nvc1 = block(@[@"笑cry",@"weibo_home",@"video"]);
    UINavigationController *nvc2 = block(@[@"震惊",@"weibo_compose",@"highlights"]);
    UINavigationController *nvc3 = block(@[@"暖心",@"weibo_message",@"scene"]);
    UINavigationController *nvc4 = block(@[@"八卦",@"weibo_favorite",@"funny"]);
    NSArray *viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    self.viewControllers=viewControllers;
}

@end
