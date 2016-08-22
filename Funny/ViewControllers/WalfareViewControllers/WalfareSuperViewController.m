//
//  WalfareSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfareSuperViewController.h"

@interface WalfareSuperViewController ()

@end

@implementation WalfareSuperViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshSuper];
    [self walfareNetRequest];
}

- (void)walfareNetRequest{
    [self netRequestWithRefresh:kNormalrefresh baseView:nil];
}

- (NSString *)requestURLStringSuper:(eRefresh)refresh
{
    if (refresh == kPushRefresh) {
        NSString *urlString=[self.pushHeadURL stringByAppendingString:self.max_timestamp];
        urlString=[urlString stringByAppendingString:self.defaultPushMiddleURL];
        urlString=[urlString stringByAppendingString:self.latest_viewed_ts];
        urlString=[urlString stringByAppendingString:self.defaultFootURL];
        return urlString;
    }else if (refresh == kPullRefresh){
        NSString *urlString=[self.pullHeadURL stringByAppendingString:self.latest_viewed_ts];
        urlString=[urlString stringByAppendingString:self.defaultFootURL];
        return urlString;
    }else{
        self.latest_viewed_ts=[NSString currentTime];
        return self.defaultURL;
    }
}

- (void)refreshSuper
{
    self.header=[YZRefreshHeaderView header];
    self.footer=[YZRefreshFooterView footer];
    self.header.scrollView=self.tableView;
    self.footer.scrollView=self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:kPullRefresh baseView:baseView];
    };
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        [weakself netRequestWithRefresh:kPushRefresh baseView:baseView];
    };

}
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    
}
@end
