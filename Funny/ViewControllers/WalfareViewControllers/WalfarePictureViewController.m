//
//  WalfarePictureViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfarePictureViewController.h"
#import "WalfarePicturesTableViewCell.h"

@interface WalfarePictureViewController ()

@end

@implementation WalfarePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLStringSuper:refresh];
    //NSLog(@"url:%@=%@",urlString,self.latest_viewed_ts);
    [NetManager requestDataWithURLString:urlString contentType:XMLL finished:^(id responseObj) {
        NSDictionary *resPonseDict=(NSDictionary *)responseObj;
        NSArray *itemsArray=resPonseDict[@"items"];
        NSDictionary *firstDict=itemsArray[0];
        if (refresh == kPullRefresh && self.dataSource.count>0) {
            WalfarePictureModel *firstModel=self.dataSource[0];
            if (![firstModel.wbody isEqualToString:firstDict[@"wbody"]]) {
                for (NSDictionary *dict in itemsArray) {
                    WalfarePictureModel *model=[[WalfarePictureModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource insertObject:model atIndex:0];
                }
            }
        }else{
            for (NSDictionary *dict in itemsArray) {
                WalfarePictureModel *model=[[WalfarePictureModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                if (refresh == kPullRefresh) {
                    [self.dataSource insertObject:model atIndex:0];
                }else{
                    [self.dataSource addObject:model];
                }
            }
        }
        WalfarePictureModel *model=[self.dataSource lastObject];
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
    return [self pictureCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self pictureCell:tableView indexPath:indexPath].rowHeight;
}

- (WalfarePicturesTableViewCell *)pictureCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    WalfarePicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"WalfarePictureCell"];
    if (!cell) {
        cell=[[WalfarePicturesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WalfarePictureCell"];
    }
    WalfarePictureModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}


@end
