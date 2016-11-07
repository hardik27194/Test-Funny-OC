//
//  AppDelegate.h
//  Funny
//
//  Created by yanzhen on 15/12/7.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SharedAppDelegate (AppDelegate*)([UIApplication sharedApplication].delegate)

@class VideoWindow;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) VideoWindow *videoWindow;

@end

