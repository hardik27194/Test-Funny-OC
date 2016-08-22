//
//  NetEaseSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//
static CGFloat const NEThreePHeight = 130;
static CGFloat const NEPHeight = 95;
static NSString *const NETPCell = @"NEThreePicturesCell";
static NSString *const NEPCell = @"NEPictureCell";

#import "NetEaseSuperViewController.h"
#import "NetEaseWebViewController.h"
#import "NEThreePicturesTableViewCell.h"
#import "NEPictureTableViewCell.h"

@interface NetEaseSuperViewController ()

@end

@implementation NetEaseSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self netRequestWithRefresh:kNormalrefresh baseView:nil];
    [self refreshSuper];
    
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
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSArray *keyArray=responseObj[self.key];
        for (NSDictionary *dict in keyArray) {
            if (!dict[@"url"]) {
                continue;
            }
            NetEaseDefaultModel *model=[[NetEaseDefaultModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (refresh == kPullRefresh) {
                NetEaseDefaultModel *firstModel=[self.dataSource firstObject];
                if ([firstModel.url isEqualToString:model.url]) {
                    break;
                }
                [self.dataSource insertObject:model atIndex:0];
            }else{
                [self.dataSource addObject:model];
            }
        }
        if (baseView) {
            [baseView endRefreshing];
        }
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"%@",errorMsg);
    }];
}
#pragma mark - tableView dataSource delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetEaseDefaultModel *model=self.dataSource[indexPath.row];
    if (model.imgextra.count) {
        NEThreePicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NETPCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"NEThreePicturesTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        return cell;
    }else{
        NEPictureTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NEPCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"NEPictureTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetEaseDefaultModel *model=self.dataSource[indexPath.row];
    if (model.imgextra.count) {
        return NEThreePHeight;
    }else{
        return NEPHeight;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetEaseDefaultModel *model=self.dataSource[indexPath.row];
    NetEaseWebViewController *vc=[[NetEaseWebViewController alloc] initWithUrlString:model.url_3w];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)requestURLString:(eRefresh)refresh
{
    static int i=1;
    if (refresh == kPushRefresh) {
        NSString *urlString=[self.pushURL stringByAppendingFormat:@"%d",i++ * 20];
        return [urlString stringByAppendingString:NetEaseDefaultFooterURL];
    }else{
        return self.defaultURL;
    }
}



@end
