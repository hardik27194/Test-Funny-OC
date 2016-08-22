//
//  SecretAddNewItemViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecretPasswordViewController;
@interface SecretAddNewItemViewController : UIViewController
//修改
- (instancetype)initWithSecretModel:(SecretModel *)model titleArray:(NSString *)title viewController:(SecretPasswordViewController *)vc indexPath:(NSIndexPath *)indexPath;
//添加
- (instancetype)initWithTitleArray:(NSArray *)titleArray viewController:(SecretPasswordViewController *)vc;
@end
