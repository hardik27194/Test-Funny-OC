//
//  WalfareTextViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfareTextViewController.h"
#import "WalfareTextTableViewCell1.h"

@interface WalfareTextViewController ()

@end

@implementation WalfareTextViewController

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
            WalfareTextModel *firstModel=self.dataSource[0];
            if (![firstModel.wbody isEqualToString:firstDict[@"wbody"]]) {
                for (NSDictionary *dict in itemsArray) {
                    WalfareTextModel *model=[[WalfareTextModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource insertObject:model atIndex:0];
                }
            }
        }else{
            for (NSDictionary *dict in itemsArray) {
                WalfareTextModel *model=[[WalfareTextModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                if (refresh == kPullRefresh) {
                    [self.dataSource insertObject:model atIndex:0];
                }else{
                    [self.dataSource addObject:model];
                }
            }
        }
        WalfareTextModel *model=[self.dataSource lastObject];
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
    WalfareTextTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"WalfareTextCell"];
    if (!cell) {
        cell=[[WalfareTextTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WalfareTextCell"];
    }
    WalfareTextModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    [self.rowHeightData setObject:@(cell.rowHeight) forKey:indexPath];
    return cell;
}


@end
