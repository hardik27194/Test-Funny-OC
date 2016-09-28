//
//  WhatSomePictureViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/14.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "WhatSomePictureViewController.h"
#import "GifShowPicturesTableViewCell.h"

@interface WhatSomePictureViewController ()
@property (strong, nonatomic) NSNumber *max_time;
@property (strong, nonatomic) NSNumber *min_time;
@property (nonatomic, strong) NSMutableDictionary *rowHeightData;
@end

@implementation WhatSomePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _rowHeightData = [[NSMutableDictionary alloc] init];
    
}
#pragma mark - net
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    NSString *urlString=[self requestURLString:refresh];
    [NetManager requestDataWithURLString:urlString contentType:JSON finished:^(id responseObj) {
        NSDictionary *responseDict=(NSDictionary *)responseObj;
        NSDictionary *dataDict=responseDict[@"data"];
        if (refresh != kPullRefresh) {
            self.max_time=dataDict[@"max_time"];
            self.min_time=dataDict[@"min_time"];
        }
        NSArray *dataArray=dataDict[@"data"];
        for (NSDictionary *valueDict in dataArray) {
            NSDictionary *groupDict=valueDict[@"group"];
            NSNumber *type=groupDict[@"type"];
            if (type.intValue != 1) {
                continue;
            }
            SomeWhatPictureModel *model=[[SomeWhatPictureModel alloc] init];
            //user
            NSDictionary *userDict=groupDict[@"user"];
            model.avatar_url=userDict[@"avatar_url"];
            model.name=userDict[@"name"];
            model.text=groupDict[@"text"];
            model.create_time=groupDict[@"create_time"];
            //
            NSDictionary *middle_imageDict=groupDict[@"middle_image"];
            model.r_height=middle_imageDict[@"r_height"];
            model.r_width=middle_imageDict[@"r_width"];
            NSArray *url_listArray=middle_imageDict[@"url_list"];
            model.url=url_listArray[0][@"url"];
            //
            if (refresh == kPullRefresh) {
                [self.dataSource insertObject:model atIndex:0];
            }else{
                [self.dataSource addObject:model];
            }
        }
        if (baseView) {
            [baseView endRefreshing];
        }
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"%@",errorMsg);
    }];
}
- (NSString *)requestURLString:(eRefresh)refresh
{
    if (refresh == kPushRefresh) {
        NSString *urlString=[SomeWhatPushHeadURL stringByAppendingFormat:@"%lld",self.max_time.longLongValue];
        urlString=[urlString stringByAppendingString:SomeWhatDefaultFootURL];
        return urlString;
    }else if (refresh == kPullRefresh){
        NSString *urlString=[SomeWhatPullHeadURL stringByAppendingString:[NSString currentTime]];
        urlString=[urlString stringByAppendingString:SomeWhatDefaultFootURL];
        return urlString;
    }else{
        
        return SomeWhatDefaultPictureURL;
    }
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GifShowPicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SomeWhatPictureCell"];
    if (!cell) {
        cell=[[GifShowPicturesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SomeWhatPictureCell"];
    }
    SomeWhatPictureModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    //可以绑定在model上面
    [self.rowHeightData setObject:@(cell.rowHeight) forKey:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *rowHeight = [self.rowHeightData objectForKey:indexPath];
    return rowHeight.floatValue > 0 ? rowHeight.floatValue : HEIGHT;
}


@end
