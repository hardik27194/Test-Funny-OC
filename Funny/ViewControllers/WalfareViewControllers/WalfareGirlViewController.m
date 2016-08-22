//
//  WalfareGirlViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfareGirlViewController.h"
#import "WalfareGirlsTableViewCell.h"

@interface WalfareGirlViewController ()

@end

@implementation WalfareGirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLStringSuper:refresh];
    [NetManager requestDataWithURLString:urlString contentType:XMLL finished:^(id responseObj) {
        NSDictionary *resPonseDict=(NSDictionary *)responseObj;
        NSArray *itemsArray=resPonseDict[@"items"];
        NSDictionary *firstDict=itemsArray[0];
        if (refresh == kPullRefresh && self.dataSource.count>0) {
            WalfareGirlModel *firstModel=self.dataSource[0];
            if (![firstModel.wbody isEqualToString:firstDict[@"wbody"]]) {
                for (NSDictionary *dict in itemsArray) {
                    WalfareGirlModel *model=[[WalfareGirlModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource insertObject:model atIndex:0];
                }
            }
        }else{
            for (NSDictionary *dict in itemsArray) {
                WalfareGirlModel *model=[[WalfareGirlModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                if (refresh == kPullRefresh) {
                    [self.dataSource insertObject:model atIndex:0];
                }else{
                    [self.dataSource addObject:model];
                }
            }
        }
        WalfareGirlModel *model=[self.dataSource lastObject];
        self.max_timestamp=model.update_time;
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    if (baseView) {
        [baseView endRefreshing];
    }
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self girlCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self girlCell:tableView indexPath:indexPath].rowHeight;
}

- (WalfareGirlsTableViewCell *)girlCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    WalfareGirlsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"WalfareGirlCell"];
    if (!cell) {
        cell=[[WalfareGirlsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WalfareGirlCell"];
    }
    WalfareGirlModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}

@end
