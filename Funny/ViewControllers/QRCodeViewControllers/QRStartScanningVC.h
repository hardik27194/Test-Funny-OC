//
//  QRStartScanningVC.h
//  Funny
//
//  Created by yanzhen on 16/1/25.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRScanningViewController;
@interface QRStartScanningVC : UIViewController
@property (nonatomic, weak) QRScanningViewController *scanVC;

- (instancetype)initWith3DTouch:(BOOL)is3DTouch;

@end
