//
//  SuperTabBarViewController.m
//  Funny
//
//  Created by yanzhen on 16/6/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "SuperTabBarViewController.h"

@interface SuperTabBarViewController ()

@end

@implementation SuperTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([self allViewControllers].count > 0) {
//        self.viewControllers = [self allViewControllers];
//    }
    
    [self.tabBar setTintColor:YZColor(255, 133, 25)];
}

-(UINavigationController *)nvcWithVCName:(NSString *)vcName title:(NSString *)title imageNameHeader:(NSString *)imageNameHeader{
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    NSString *uImageName = [imageNameHeader stringByAppendingString:@"_u"];
    NSString *sImageName = [imageNameHeader stringByAppendingString:@"_s"];
    UIImage *unSelectImage = [UIImage imageNamedWithTabBar:uImageName];
    UIImage *selectImage = [UIImage imageNamedWithTabBar:sImageName];
    [nvc.tabBarItem setImage:unSelectImage];
    [nvc.tabBarItem setSelectedImage:selectImage];
    return nvc;
}

@end
