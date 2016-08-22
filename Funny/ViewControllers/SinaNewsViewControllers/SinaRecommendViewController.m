//
//  SinaRecommendViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaRecommendViewController.h"
#import "SinaMacro.h"

@interface SinaRecommendViewController ()

@end

@implementation SinaRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *dataDict=responseObj[@"data"];
        NSArray *listArray=dataDict[@"list"];
        int j=0;
        for (NSDictionary *dict in listArray) {
            SinaNewsModel *model=[[SinaNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (!model.kpic) {
                continue;
            }
            if (refresh == kPullRefresh) {
                if (j==0) {
                    SinaNewsModel *testModel=self.dataSource[0];
                    if ([testModel.title isEqualToString:model.title]) {
                        break;
                    }
                }
                [self.dataSource insertObject:model atIndex:0];
            }else{
                [self.dataSource addObject:model];
            }
            j++;
        }
        if (baseView) {
            [baseView endRefreshing];
        }
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"%@",errorMsg);
    }];
}

-(NSString *)requestURLString:(eRefresh)refresh
{
    static NSInteger offset=21;
    if (refresh == kPushRefresh) {
        NSString *urlString=[SinaRecommendPushHeadURL stringByAppendingFormat:@"%ld",offset];
        offset+=20;
        urlString = [urlString stringByAppendingString:SinaNewsDefaultFootURL];
        return [urlString stringByAppendingString:self.titleName];
    }else if(refresh == kNormalrefresh){
        return SinaRecommendNormalURL;
    }else{
        NSString *urlString=[SinaRecommendPullHeadURL stringByAppendingFormat:@"%ld",offset];
        offset+=6;
        urlString = [urlString stringByAppendingString:SinaNewsDefaultFootURL];
        return [urlString stringByAppendingString:self.titleName];
    }
}
@end
