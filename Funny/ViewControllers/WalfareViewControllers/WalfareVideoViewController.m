//
//  WalfareVideoViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WalfareVideoViewController.h"
#import "WalfareVideoTableViewCell1.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"


@interface WalfareVideoViewController ()<VideoPlayDelegate>

@end

@implementation WalfareVideoViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tableView reloadData];
}
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
            WalfareVideoModel *firstModel=self.dataSource[0];
            if (![firstModel.wbody isEqualToString:firstDict[@"wbody"]]) {
                for (NSDictionary *dict in itemsArray) {
                    WalfareVideoModel *model=[[WalfareVideoModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataSource insertObject:model atIndex:0];
                }
            }
        }else{
            for (NSDictionary *dict in itemsArray) {
                WalfareVideoModel *model=[[WalfareVideoModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                if (refresh == kPullRefresh) {
                    [self.dataSource insertObject:model atIndex:0];
                }else{
                    [self.dataSource addObject:model];
                }
            }
        }
        WalfareVideoModel *model=[self.dataSource lastObject];
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
    return [self videoCell:tableView indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self videoCell:tableView indexPath:indexPath].rowHeight;
}

- (WalfareVideoTableViewCell1 *)videoCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    WalfareVideoTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"WalfareVideoCell"];
    if (!cell) {
        cell=[[WalfareVideoTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WalfareVideoCell"];
    }
    WalfareVideoModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    cell.delegate=self;
    if (cell.refresh) {
        [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
        cell.playBtn.selected = NO;
    }
    return cell;
}

#pragma mark - playButtonClick

-(void)videoPlay:(BOOL)play videoCell:(FunnyVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    WalfareVideoModel *model = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:model.vplay_url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:model.vplay_url play:play];
    }
}

-(void)playVideoOnWindow:(FunnyVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WalfareVideoModel *model = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:model.vplay_url];
}


@end
