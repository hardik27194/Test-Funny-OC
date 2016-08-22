//
//  SuperBuDeJieViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/12.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperBuDeJieViewController.h"

@interface SuperBuDeJieViewController ()

@end

@implementation SuperBuDeJieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self budejieSuperRefresh];
    [self budejieSuperNetRequest];
}



-(void)budejieSuperNetRequest{
    [self netRequestWithRefresh:kNormalrefresh baseView:nil];
}

- (void)budejieSuperRefresh
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

-(void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView{
    
}

@end
