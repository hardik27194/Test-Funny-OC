//
//  NetEaseContentViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NetEaseContentViewController.h"
#import "NEContentTableViewCell.h"

@interface NetEaseContentViewController ()

@end

@implementation NetEaseContentViewController
{
    NEContentTableViewCell *_cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
- (NSString *)requestURLString:(eRefresh)refresh
{
    return self.defaultURL;
}

- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    YZLog(@"%@",urlString);
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSArray *keyArray=responseObj[@"段子"];
        for (NSDictionary *dict in keyArray) {
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
    _cell=[tableView dequeueReusableCellWithIdentifier:@"NEContentCell"];
    if (!_cell) {
        _cell=[[NEContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NEContentCell"];
    }
    NetEaseDefaultModel *model=self.dataSource[indexPath.row];
    _cell.model=model;
    return _cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_cell) {
        _cell=[[NEContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NEContentCell"];
    }
    NetEaseDefaultModel *model=self.dataSource[indexPath.row];
    _cell.model=model;
    return _cell.rowHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UCNewsModel *model=self.dataSource[indexPath.row];
    //    WebViewController *vc=[[WebViewController alloc] initWithUrlString:model.original_url];
    //    vc.hidesBottomBarWhenPushed=YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
