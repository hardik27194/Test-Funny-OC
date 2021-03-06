//
//  BuDeJieRankViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/13.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "BuDeJieRankViewController.h"
#import "BuDeJieVideoTableViewCell1.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface BuDeJieRankViewController ()<VideoPlayDelegate>

@end

@implementation BuDeJieRankViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tableView reloadData];
}

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
            NSString *type=dict[@"type"];
            if (type.intValue != 41) {
                continue;
            }
            BuDeJieVideoModel *model=[[BuDeJieVideoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (self.dataSource.count>0 && i==0) {
                BuDeJieVideoModel *textModel=self.dataSource[0];
                if ([model.videouri isEqualToString:textModel.videouri]) {
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuDeJieVideoTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"BuDeJieVideoCell"];
    if (!cell) {
        cell=[[BuDeJieVideoTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuDeJieVideoCell"];
    }
    BuDeJieVideoModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    cell.delegate=self;
    if (cell.refresh) {
        [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
        cell.playBtn.selected = NO;
    }
    [self.rowHeightData setObject:@(cell.rowHeight) forKey:indexPath];
    return cell;
}

#pragma mark - play-Action
-(void)videoPlay:(BOOL)play videoCell:(FunnyVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    BuDeJieVideoModel *model = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:model.videouri];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:model.videouri play:play];
    }
}

-(void)playVideoOnWindow:(FunnyVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BuDeJieVideoModel *model = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:model.videouri];
}


- (NSString *)urlStringWithRefresh:(eRefresh)refresh
{
    if (refresh == kPushRefresh) {
        NSString *urlString=[BuDeJieRankingPushHeadURL stringByAppendingFormat:@"%lld",self.maxtime.longLongValue];
        return [urlString stringByAppendingString:BuDeJieAllPushFoodURL];
    }else{
        return BudeJieRankingDefaultURL;
    }
}

@end
