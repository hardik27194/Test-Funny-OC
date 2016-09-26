//
//  ContentVideoViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ContentVideoViewController.h"
#import "SuperWebViewController.h"
#import "ContentVideoTableViewCell1.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"

@interface ContentVideoViewController ()<VideoPlayDelegate>

@end

@implementation ContentVideoViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (NSString *)netUrl:(eRefresh)refresh
{
    NSString *urlString=@" ";
    if (refresh == kNormalrefresh) {
        urlString=[ConTentVideoMaxHeadURL stringByAppendingString:[NSString currentTime]];
        urlString=[urlString stringByAppendingString:ContentVideoMaxFootURL];
    }else if (refresh == kPullRefresh){
        urlString=[ConTentVideoMaxHeadURL stringByAppendingFormat:@"%lld", self.maxTime];
        urlString=[urlString stringByAppendingString:ContentVideoMaxFootURL];
    }else if(refresh == kPushRefresh){
        urlString=[ContentVideoMinHeadURL stringByAppendingFormat:@"%lld", self.minTime];
        urlString=[urlString stringByAppendingString:ContentVideoMinFootURL];
    }
    return urlString;
}

#pragma mark - net
-(void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView isHeaderRefresh:(BOOL)end{
    NSString *urlString=[self netUrl:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *responseDict=(NSDictionary *)responseObj;
        NSDictionary *dataDict=responseDict[@"data"];
        ContentVideoDataModel *dataModel=[[ContentVideoDataModel alloc] init];
        [dataModel setValuesForKeysWithDictionary:dataDict];
        if (!baseView && !end) {
            self.minTime=dataModel.min_time;
            self.maxTime=dataModel.max_time;
        }else if (baseView && !end){
            self.minTime=dataModel.min_time;
        }else{
            self.maxTime=dataModel.max_time;
        }
        //
        NSArray *dataArray=dataDict[@"data"];
        for (NSDictionary *dict in dataArray) {
            NSArray *cArray=dict[@"comments"];
            ContentVideoCommentsModel *commentsModel=[[ContentVideoCommentsModel alloc] init];
            if (cArray.count > 0) {
                [commentsModel setValuesForKeysWithDictionary:cArray[0]];
            }else{
                commentsModel.text=NOTEXT;
            }
            //
            NSDictionary *groupDict=dict[@"group"];
            ContentVideoGroupModel *groupModel=[[ContentVideoGroupModel alloc] init];
            //user
            NSDictionary *userDict=groupDict[@"user"];
            groupModel.avatar_url=userDict[@"avatar_url"];
            groupModel.name=userDict[@"name"];
            //
            groupModel.share_url=groupDict[@"share_url"];
            groupModel.text=groupDict[@"text"];
            groupModel.create_time=groupDict[@"create_time"];
            groupModel.mp4_url=groupDict[@"mp4_url"];
            groupModel.duration=groupDict[@"duration"];
            if (!groupModel.mp4_url) {
                continue;
            }
            //
            NSDictionary *large_coverDict=groupDict[@"large_cover"];
            NSArray *imageListArray=large_coverDict[@"url_list"];
            groupModel.imageURL=imageListArray[0][@"url"];
            //
            NSDictionary *videoDict=groupDict[@"720p_video"];
            groupModel.width=videoDict[@"width"];
            groupModel.height=videoDict[@"height"];
            NSArray *videoListArray=videoDict[@"url_list"];
            groupModel.url=videoListArray[0][@"url"];
            //
            if (end) {
                [self.commentsArray insertObject:commentsModel atIndex:0];
                [self.groupArray insertObject:groupModel atIndex:0];
            }else{
                [self.commentsArray addObject:commentsModel];
                [self.groupArray addObject:groupModel];
            }
        }
        [self.dataSource insertObject:self.commentsArray atIndex:0];
        [self.dataSource insertObject:self.groupArray atIndex:1];
        if (baseView) {
            [baseView endRefreshing];
        }
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"error:%@",errorMsg);
    }];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count>=1) {
        NSArray *array=self.dataSource[1];
        return array.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentVideoTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"ContentVideoCell"];
    if (!cell) {
        cell=[[ContentVideoTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentVideoCell"];
        cell.delegate=self;
    }
    if (cell.refresh) {
        [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
        cell.playBtn.selected = NO;
    }
    NSArray *commentsArray=self.dataSource[0];
    NSArray *groupArray=self.dataSource[1];
    cell.groupModel=groupArray[indexPath.row];
    ContentVideoCommentsModel *model=commentsArray[indexPath.row];
    if ([model.text isEqualToString:NOTEXT]) {
        cell.smallView.hidden = YES;
    }else{
        cell.smallView.hidden = NO;
        cell.commentModel=model;
    }
    [self.rowHeightData setObject:@(cell.rowHeight) forKey:indexPath];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentVideoGroupModel *model=self.dataSource[1][indexPath.row];
    NSString *urlString=model.share_url;
    ContentWebViewController *vc=[[ContentWebViewController alloc] initWithUrlString:urlString];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - playButton delegate
-(void)videoPlay:(BOOL)play videoCell:(FunnyVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    ContentVideoGroupModel *model = self.groupArray[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:model.url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:model.url play:play];
    }
}

-(void)playVideoOnWindow:(FunnyVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ContentVideoGroupModel *model = self.groupArray[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:model.url];
}
@end
