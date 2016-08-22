//
//  ContentPictureViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ContentPictureViewController.h"
#import "ContentPicturesTableViewCell.h"
#import "SuperWebViewController.h"

@interface ContentPictureViewController ()

@end

@implementation ContentPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (NSString *)netUrl:(eRefresh)refresh
{
    NSString *urlString=@" ";
    if (refresh == kNormalrefresh) {
        urlString=[ContentPictureMaxHeadURL stringByAppendingString:[NSString currentTime]];
        urlString=[urlString stringByAppendingString:ContentPictureMaxTailURL];
    }else if (refresh == kPullRefresh){
        urlString=[ContentPictureMaxHeadURL stringByAppendingFormat:@"%lld", self.maxTime];
        urlString=[urlString stringByAppendingString:ContentPictureMaxTailURL];
    }else if(refresh == kPushRefresh){
        urlString=[ContentPictureMinHeadURL stringByAppendingFormat:@"%lld", self.minTime];
        urlString=[urlString stringByAppendingString:ContentPictureMinTailURL];
    }
    return urlString;
}
#pragma mark - Net
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView isHeaderRefresh:(BOOL)end{
    NSString *urlString=[self netUrl:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *responseDict=(NSDictionary *)responseObj;
        NSDictionary *dataDict=responseDict[@"data"];
        ContentPictureDataModel *dataModel=[[ContentPictureDataModel alloc] init];
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
            ContentPictureCommentModel *commentModel=[[ContentPictureCommentModel alloc] init];
            if (cArray.count>0) {
                NSDictionary *valueDict=cArray[0];
                [commentModel setValuesForKeysWithDictionary:valueDict];
            }else{
                commentModel.text=NOTEXT;
            }
            //
            NSDictionary *groupDict=dict[@"group"];
            ContentPictureGroupModel *groupModel=[[ContentPictureGroupModel alloc] init];
            groupModel.share_url=groupDict[@"share_url"];
            groupModel.text=groupDict[@"text"];
            groupModel.create_time=groupDict[@"create_time"];
            //
            NSDictionary *middleImageDict=groupDict[@"large_image"];
            groupModel.r_height=middleImageDict[@"r_height"];
            groupModel.r_width=middleImageDict[@"r_width"];
            if (groupModel.r_width.intValue == 0) {
                continue;
            }
            NSArray *url_listArray=middleImageDict[@"url_list"];
            groupModel.url=url_listArray[0][@"url"];
            //url
            NSDictionary *userDict=groupDict[@"user"];
            groupModel.avatar_url=userDict[@"avatar_url"];
            groupModel.name=userDict[@"name"];
            //
            if (end) {
                [self.commentsArray insertObject:commentModel atIndex:0];
                [self.groupArray insertObject:groupModel atIndex:0];
            }else{
                [self.commentsArray addObject:commentModel];
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
        YZLog(@"%@",errorMsg);
    }];
    
    
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=nil;
    if (self.dataSource.count>=1) {
        array=self.dataSource[1];
    }
    return array.count;
}

- (ContentPicturesTableViewCell *)pictureCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    ContentPicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContentPictureCell"];
    if (!cell) {
        cell=[[ContentPicturesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentPictureCell"];
    }
    NSArray *commentsArray=self.dataSource[0];
    NSArray *groupArray=self.dataSource[1];
    cell.groupModel=groupArray[indexPath.row];
    ContentPictureCommentModel *model=commentsArray[indexPath.row];
    if ([model.text isEqualToString:NOTEXT]) {
        cell.smallView.hidden=YES;
    }else{
        cell.smallView.hidden=NO;
        cell.commentModel=model;
    }
    return cell;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self pictureCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self pictureCell:tableView indexPath:indexPath].rowHeight;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentPictureGroupModel *model=self.dataSource[1][indexPath.row];
    NSString *urlString=model.share_url;
    ContentWebViewController *vc=[[ContentWebViewController alloc] initWithUrlString:urlString];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
