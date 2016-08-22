//
//  GifShowSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "GifShowSuperViewController.h"

@interface GifShowSuperViewController ()

@end

@implementation GifShowSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self gifShowRefresh];
    [self gifShowNetRequest];
}

- (void)gifShowNetRequest{
    [self netRequestWithRefresh:kNormalrefresh baseView:nil];
}

- (void)gifShowRefresh
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

- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView{
    
}
@end
