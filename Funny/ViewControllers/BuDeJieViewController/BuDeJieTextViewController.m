
//
//  BuDeJieTextViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/12.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "BuDeJieTextViewController.h"
#import "BuDEJieTextTableViewCell1.h"
#import "SuperWebViewController.h"

@interface BuDeJieTextViewController ()

@end

@implementation BuDeJieTextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - net
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self urlStringWithRefresh:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *responseDict=(NSDictionary *)responseObj;
        NSDictionary *infoDict=responseDict[@"info"];
        self.maxid=infoDict[@"maxid"];
        self.maxtime=infoDict[@"maxtime"];
        //
        int i=0;
        NSArray *listArray=responseDict[@"list"];
        for (NSDictionary *dict in listArray) {
            BuDeJieTextModel *model=[[BuDeJieTextModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (self.dataSource.count>0 && i==0) {
                BuDeJieTextModel *textModel=self.dataSource[0];
                if ([model.text isEqualToString:textModel.text]) {
                    break;
                }
            }
            if (kPullRefresh == refresh) {
                [self.dataSource insertObject:model atIndex:0];
            }else
            {
                [self.dataSource addObject:model];
            }
            i++;
        }
        if (baseView) {
            [baseView endRefreshing];
        }
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
}
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (BuDEJieTextTableViewCell1 *)textCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    BuDEJieTextTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"BuDeJieTextCell"];
    if (!cell) {
        cell=[[BuDEJieTextTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuDeJieTextCell"];
    }
    BuDeJieTextModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self textCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self textCell:tableView indexPath:indexPath].rowHeight;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BuDeJieTextModel *model=self.dataSource[indexPath.row];
//    WebViewController *wvc=[[WebViewController alloc] initWithUrlString:@"http://bbs.tianya.cn/hotArticle.jsp?pn=0"];
//    [self.navigationController pushViewController:wvc animated:YES];
}

- (NSString *)urlStringWithRefresh:(eRefresh)refresh
{
    if (refresh == kPushRefresh) {
        return [NSString stringWithFormat:BuDeJieTextPushURL,self.maxid];
    }else{
        return BuDeJieTextUrl;
    }
}
@end
