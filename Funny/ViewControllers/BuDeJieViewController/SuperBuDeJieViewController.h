//
//  SuperBuDeJieViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/12.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"
#import "BuDeJieMacro.h"

@interface SuperBuDeJieViewController : SuperThirdViewController<UITableViewDataSource,UITableViewDelegate>
@property (copy, nonatomic) NSString *maxid;
@property (copy, nonatomic) NSString *maxtime;

- (void)budejieSuperRefresh;
- (void)budejieSuperNetRequest;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView;
@end
