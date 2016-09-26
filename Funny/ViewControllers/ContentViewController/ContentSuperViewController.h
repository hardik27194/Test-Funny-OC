//
//  ContentSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"
#import "ContentOtherUserView.h"
#import "ContentWebViewController.h"
#import "ContentMacro.h"

@interface ContentSuperViewController : SuperThirdViewController
@property (nonatomic, strong) NSMutableDictionary *rowHeightData;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, strong) NSMutableArray *groupArray;
@property (assign, nonatomic) CGFloat rowHeight;
@property (assign ,nonatomic) long long maxTime;
@property (assign ,nonatomic) long long minTime;

- (void)superRefresh;
- (void)superOther;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView isHeaderRefresh:(BOOL)end;
@end
