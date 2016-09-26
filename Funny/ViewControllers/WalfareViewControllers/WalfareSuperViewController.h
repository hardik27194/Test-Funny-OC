//
//  WalfareSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"

@interface WalfareSuperViewController :SuperThirdViewController

@property (nonatomic, strong) NSMutableDictionary *rowHeightData;
@property (copy, nonatomic) NSString *defaultURL;
@property (copy, nonatomic) NSString *defaultFootURL;
@property (copy, nonatomic) NSString *defaultPushMiddleURL;
@property (copy, nonatomic) NSString *pullHeadURL;
@property (copy, nonatomic) NSString *pushHeadURL;
@property (copy, nonatomic) NSString *max_timestamp;
@property (copy, nonatomic) NSString *latest_viewed_ts;

- (NSString *)requestURLStringSuper:(eRefresh)refresh;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView;
@end
