//
//  BuDeJiePictureViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/12.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "BuDeJiePictureViewController.h"
#import "BuDeJiePicturesTableViewCell.h"

@interface BuDeJiePictureViewController ()

@end

@implementation BuDeJiePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark - net
-(void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
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
            BuDeJiePictureModel *model=[[BuDeJiePictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (self.dataSource.count>0 && i==0) {
                BuDeJiePictureModel *textModel=self.dataSource[0];
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
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuDeJiePicturesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BuDeJiePictureCell"];
    if (!cell) {
        cell=[[BuDeJiePicturesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuDeJiePictureCell"];
    }
    BuDeJiePictureModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    [self.rowHeightData setObject:@(cell.rowHeight) forKey:indexPath];
    return cell;
}

#pragma mark - URL
- (NSString *)urlStringWithRefresh:(eRefresh)refresh
{
    if (refresh == kPushRefresh) {
        NSString *urlString=[BuDeJieVideoPushHeadURL stringByAppendingString:self.maxtime];
        return [urlString stringByAppendingString:BuDeJieVideoPushFootURL];
    }else{
        return BuDeJiePictureDefaultURL;
    }
}
@end
