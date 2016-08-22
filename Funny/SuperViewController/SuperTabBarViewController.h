//
//  SuperTabBarViewController.h
//  Funny
//
//  Created by yanzhen on 16/6/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperTabBarViewController : UITabBarController
- (UINavigationController *)nvcWithVCName:(NSString *)vcName title:(NSString *)title imageNameHeader:(NSString *)imageNameHeader;
@end
