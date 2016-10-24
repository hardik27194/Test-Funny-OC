//
//  AppDelegate.m
//  Funny
//
//  Created by yanzhen on 15/12/7.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "Reachability.h"
#import "SDWebImageManager.h"
#import "QRScanningViewController.h"
#import "QRStartScanningVC.h"
#import "VideoWindow.h"
#import "WXApi.h"

@interface AppDelegate ()
@property (strong ,nonatomic) Reachability *reachability;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController *root=[[RootViewController alloc] init];
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController=nvc;
    self.window.backgroundColor=[UIColor whiteColor];
    
    self.videoWindow = [[VideoWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.videoWindow.backgroundColor = [UIColor clearColor];
    self.videoWindow.windowLevel = UIWindowLevelAlert + 1;
    
    //test gitHub
    //[MAMapServices sharedServices].apiKey=aMapKey;
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:YZColor(255, 133, 25)}];
    [appearance setTintColor:YZColor(255, 133, 25)];
    
    _reachability=[Reachability reachabilityForInternetConnection];
    [_reachability startNotifier];
    
    
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"扫描二维码" localizedTitle:@"扫描二维码"];
//    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"弹框" localizedTitle:@"弹框"];
    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
    
    [self.window makeKeyAndVisible];

    [WXApi registerApp:@"wx188b02f35eb50c9c"];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:self];
//}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.localizedTitle  isEqual: @"扫描二维码"]) {
        QRStartScanningVC *vc = [[QRStartScanningVC alloc] initWith3DTouch:YES];
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

- (NetworkStatus)netStatus
{
    return [_reachability currentReachabilityStatus];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.scheme isEqualToString:@"BCYZ"]) {
        NSArray *subString = [url.absoluteString componentsSeparatedByString:@"//"];
        NSString *tagString = subString[1];
        UINavigationController *rootVC = (UINavigationController *)self.window.rootViewController;
        RootViewController *vc = rootVC.viewControllers.firstObject;
        //只考虑push和present一级的情况
        if (rootVC.presentedViewController) {
            [rootVC.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }else if (rootVC.viewControllers.count > 1){
            [rootVC popToRootViewControllerAnimated:YES];
        }
        if (tagString.integerValue >= 100 && tagString.integerValue <= 102) {
            
            NSInteger tag = tagString.integerValue;
            if (tag == 102) {
                tag = 108;
            }
            [vc selectedBtn:tag];
        }else{
            QRStartScanningVC *vc = [[QRStartScanningVC alloc] initWith3DTouch:YES];
            [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[GlobalManage shareGlobalManage] clearCache];
}
@end
