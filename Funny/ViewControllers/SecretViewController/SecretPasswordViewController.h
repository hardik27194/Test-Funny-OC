//
//  SecretPasswordViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/27.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SecretPathHeader [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data"]
#define SecretV2FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/v2.data"]
#define SecretAppleFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/apple.data"]
#define SecretMailFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/mail.data"]
#define SecretGameFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/game.data"]
#define SecretBaiduFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/baidu.data"]
#define SecretQQFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/QQ.data"]
#define SecretAlibabaFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/alibaba.data"]
#define SecretOtherFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/other.data"]
#define SecretNowFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data/now.data"]
@interface SecretPasswordViewController : UIViewController
- (void)renewAllSource;
- (void)addNewPassword:(SecretModel *)model row:(NSInteger)row;
- (void)modifyPassword:(SecretModel *)model  indexPath:(NSIndexPath *)indexPath;
@end
