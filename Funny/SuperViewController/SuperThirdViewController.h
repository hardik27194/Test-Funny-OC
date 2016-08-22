//
//  SuperThirdViewController.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "SuperSecondViewController.h"
#import "NetManager.h"
#import "YZRefresh.h"

@interface SuperThirdViewController : SuperSecondViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) YZRefreshHeaderView *header;
@property (nonatomic, strong) YZRefreshFooterView *footer;
@end
