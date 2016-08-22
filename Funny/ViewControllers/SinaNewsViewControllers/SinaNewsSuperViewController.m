//
//  SinaNewsSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//



#import "SinaNewsSuperViewController.h"
#import "SinaThreePicturesTableViewCell.h"
#import "SinaPictureTableViewCell.h"
#import "SuperWebViewController.h"
#import "SinaMacro.h"

#define SinaThreePCell @"SinaThreePicturesCell"
#define SinaPCell @"SinaPictureCell"
#define SinaTPHeight 130
#define SinaPHeight 95
@interface SinaNewsSuperViewController ()

@end

@implementation SinaNewsSuperViewController
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
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"%@",errorMsg);
    }];
}
-(NSString *)requestURLString:(eRefresh)refresh
{
    static int i=2;
    if (refresh == kPushRefresh) {
        NSString *urlString=[SinaNewsDefaultHeadURL stringByAppendingFormat:@"%d",i++];
        urlString = [urlString stringByAppendingString:SinaNewsDefaultFootURL];
        return [urlString stringByAppendingString:self.titleName];
    }else{
        NSString *urlString=[SinaNewsDefaultHeadURL stringByAppendingString:@"1"];
        urlString = [urlString stringByAppendingString:SinaNewsDefaultFootURL];
        return [urlString stringByAppendingString:self.titleName];
    }
}
#pragma mark - tableView dataSource delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SinaNewsModel *model=self.dataSource[indexPath.row];
    if (model.pics.count>2) {
        SinaThreePicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SinaThreePCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SinaThreePicturesTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        return cell;
    }else{
        SinaPictureTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SinaPCell];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"SinaPictureTableViewCell" owner:self options:nil] lastObject];
        }
        cell.model=model;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SinaNewsModel *model=self.dataSource[indexPath.row];
    if (model.pics.count>2) {
        return SinaTPHeight;
    }else{
        return SinaPHeight;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SinaNewsModel *model=self.dataSource[indexPath.row];
    SuperWebViewController *vc=[[SuperWebViewController alloc] initWithUrlString:model.link];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
