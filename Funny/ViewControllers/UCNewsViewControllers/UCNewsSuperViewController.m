//
//  UCNewsSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/17.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "UCNewsSuperViewController.h"
#import "UCNewsThreePicturesTableViewCell.h"
#import "UCNewsPictureTableViewCell.h"
#import "SuperWebViewController.h"

static CGFloat const UCThreePictureRowHeight = 128.9;
static CGFloat const UCPictureRowHeight = 80.0;
static NSString *const UCThreePictureCell = @"UCThreePictureCell";
static NSString *const UCPictureCell = @"UCPictureCell";

@implementation UCNewsSuperViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self netRequestWithRefresh:kNormalrefresh baseView:nil];
    [self refreshSuper];
    
}

- (NSString *)requestURLString:(eRefresh)refresh
{
    if (refresh == kNormalrefresh) {
        NSString *urlString=[self.UCNewsHeadURL stringByAppendingString:@"0"];
        urlString=[urlString stringByAppendingString:self.UCNewsMiddleURL];
        long long currentTime=[NSString currentTime].longLongValue;
        urlString=[urlString stringByAppendingFormat:@"%lld",currentTime*1000];
        return [urlString stringByAppendingString:self.UCNewsFootURL];
    }else{
        long long currentTime=[NSString currentTime].longLongValue;
        NSString *urlString=[self.UCNewsHeadURL stringByAppendingFormat:@"%lld",currentTime*1000];
        urlString=[urlString stringByAppendingString:self.UCNewsMiddleURL];
        urlString=[urlString stringByAppendingFormat:@"%lld",currentTime*1000+35];
        return [urlString stringByAppendingString:self.UCNewsFootURL];

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
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *dataDict=responseObj[@"data"];
        NSDictionary *articlesDict=dataDict[@"articles"];
        for (NSString *key in articlesDict) {
            UCNewsModel *model=[[UCNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:articlesDict[key]];
            if (model.thumbnails.count !=1 && model.thumbnails.count !=3) {
                continue;
            }
            if (refresh == kPullRefresh) {
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
    UCNewsModel *model=self.dataSource[indexPath.row];
    if (model.thumbnails.count == 3) {
        UCNewsThreePicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:UCThreePictureCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"UCNewsThreePicturesTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = YZColor(246, 246, 246);
        return cell;
    }else if (model.thumbnails.count == 1)
    {
        UCNewsPictureTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:UCPictureCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"UCNewsPictureTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = YZColor(246, 246, 246);
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCNewsModel *model=self.dataSource[indexPath.row];
    CGFloat rowHeight=0.0f;
    if (model.thumbnails.count == 3) {
        rowHeight=UCThreePictureRowHeight;
    }else if(model.thumbnails.count == 1){
        rowHeight=UCPictureRowHeight;
    }
    return rowHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCNewsModel *model=self.dataSource[indexPath.row];
    SuperWebViewController *vc=[[SuperWebViewController alloc] initWithUrlString:model.url];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
