//
//  ContentSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ContentSuperViewController.h"

@interface ContentSuperViewController ()

@end

@implementation ContentSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self superRefresh];
    [self superOther];
}

- (void)superRefresh
{
    self.header=[YZRefreshHeaderView header];
    self.footer=[YZRefreshFooterView footer];
    self.header.scrollView=self.tableView;
    self.footer.scrollView=self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:kPullRefresh baseView:baseView isHeaderRefresh:YES];
    };
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:kPushRefresh baseView:baseView isHeaderRefresh:NO];
    };

}
- (void)superOther
{
    self.commentsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.groupArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.rowHeightData = [[NSMutableDictionary alloc] init];
    [self netRequestWithRefresh:kNormalrefresh baseView:nil isHeaderRefresh:NO];
}

- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView isHeaderRefresh:(BOOL)end{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *rowHeight = [self.rowHeightData objectForKey:indexPath];
    //当rowHeightData没有数据时，结果为0，如果返回0的话就会开辟数组数量的空间
    return rowHeight.floatValue > 0 ? rowHeight.floatValue : HEIGHT;
}
@end
