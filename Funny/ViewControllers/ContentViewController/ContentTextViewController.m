//
//  ContentTextViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ContentTextViewController.h"
#import "ContentTextTableViewCell.h"
#import "SuperWebViewController.h"

@interface ContentTextViewController ()

@end

@implementation ContentTextViewController
{
    NSMutableArray *_dataGroup;
    ContextTextOutModel *_outModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataGroup=[[NSMutableArray alloc] init];
    _outModel=[[ContextTextOutModel alloc] init];
    self.minTime=(long long)[[NSDate date] timeIntervalSince1970];
    NSString *urlString=[self nowAndHeaderRefresh];
    [self netRequestWithUrl:urlString withBaseView:nil isHeaderRefresh:NO];
    
}
- (void)superRefresh
{
    self.header=[YZRefreshHeaderView header];
    self.footer=[YZRefreshFooterView footer];
    self.header.scrollView=self.tableView;
    self.footer.scrollView=self.tableView;
    YZWeakSelf(self)
    self.header.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        NSString *urlString=[ContextTextHeadURL stringByAppendingFormat:@"%lld", weakself.maxTime];
        urlString=[urlString stringByAppendingString:ContextTextTailUrl];
        [weakself netRequestWithUrl:urlString withBaseView:baseView isHeaderRefresh:YES];
    };
    self.footer.beginRefreshingBlock=^(YZRefreshBaseView *baseView){
        NSString *urlString=[ConTentTextFooterURL stringByAppendingFormat:@"%lld", weakself.minTime];
        urlString=[urlString stringByAppendingString:ConTentTextTailerURL];
        [weakself netRequestWithUrl:urlString withBaseView:baseView isHeaderRefresh:NO];
    };
    
}
- (NSString *)nowAndHeaderRefresh
{
    NSString *urlString=[ContextTextHeadURL stringByAppendingString:[NSString currentTime]];
    [urlString stringByAppendingString:ContextTextTailUrl];
    return urlString;
}

- (void)netRequestWithUrl:(NSString *)urlString withBaseView:(YZRefreshBaseView *)baseView isHeaderRefresh:(BOOL)end
{
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *result=(NSDictionary *)responseObj;
        NSDictionary *data1=[result objectForKey:DATA];
        [_outModel setValuesForKeysWithDictionary:data1];
        if (!baseView && !end) {
            self.minTime=_outModel.min_time;
            self.maxTime=_outModel.max_time;
        }else if (baseView && !end){
            self.minTime=_outModel.min_time;
        }else{
            self.maxTime=_outModel.max_time;
        }
        NSArray *array=[data1 objectForKey:DATA];
        for (NSDictionary *dict in array) {
            ContextTextGroupModel *groupModel=[[ContextTextGroupModel alloc] init];
            NSDictionary *groupDict=[dict objectForKey:@"group"];
            if (!groupDict) {
                continue;
            }
            [groupModel setValuesForKeysWithDictionary:groupDict];
            if (end) {
                [_dataGroup insertObject:groupModel atIndex:0];
            }else{
                [_dataGroup addObject:groupModel];
            }
            NSArray *commentsArray=[dict objectForKey:@"comments"];
            ContentTextModel *textModel=[[ContentTextModel alloc] init];
            if (commentsArray.count>0) {
                [textModel setValuesForKeysWithDictionary:commentsArray[0]];
            }else{
                textModel.text=NOTEXT;
            }
            if (end) {
                [self.dataSource insertObject:textModel atIndex:0];
            }else{
                [self.dataSource addObject:textModel];
            }
        }
        if (baseView) {
            [baseView endRefreshing];
        }
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
    
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataGroup.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self textCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self textCell:tableView indexPath:indexPath].rowHeight;
}

- (ContentTextTableViewCell *)textCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    ContentTextTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContextTextCell"];
    if (!cell) {
        cell=[[ContentTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContextTextCell"];
    }
    ContextTextGroupModel *groupModel=_dataGroup[indexPath.row];
    ContentTextModel *model=self.dataSource[indexPath.row];
    cell.groupModel = groupModel;
    if (![model.text isEqualToString:NOTEXT]) {
        cell.smallView.hidden=NO;
        cell.textModel = model;
    }else{
        cell.smallView.hidden=YES;
    }
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContextTextGroupModel *model=_dataGroup[indexPath.row];
    NSString *urlString=model.share_url;
    ContentWebViewController *vc=[[ContentWebViewController alloc] initWithUrlString:urlString];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
