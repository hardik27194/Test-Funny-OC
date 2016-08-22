//
//  NetEaseHeadLineViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NetEaseHeadLineViewController.h"

@interface NetEaseHeadLineViewController ()

@end

@implementation NetEaseHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    NSString *type=XMLL;
    if (refresh == kPushRefresh) {
        type=JSON;
    }
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

- (NSString *)requestURLString:(eRefresh)refresh
{
    static int i=7;
    if (refresh == kPushRefresh) {
        NSString *urlString=[self.pushURL stringByAppendingFormat:@"%d",i++ * 20];
        return [urlString stringByAppendingString:NetEaseDefaultFooterURL];
    }else{
        return self.defaultURL;
    }
}
@end
