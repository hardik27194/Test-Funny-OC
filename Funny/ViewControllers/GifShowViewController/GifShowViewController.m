//
//  GifShowViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "GifShowViewController.h"
#import "GifShowVideoTableViewCell1.h"
#import "FunnyVideoPlayManage.h"
#import "WindowViewManager.h"


@interface GifShowViewController ()<VideoPlayDelegate>
@property (strong, nonatomic) NSArray *pageArray;
@property (strong, nonatomic) NSArray *downArray;
@property (strong, nonatomic) YZRefreshBaseView *baseView;
@property (assign, nonatomic) eRefresh refresh;
@end

@implementation GifShowViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)gifShowNetRequest{
    [self netRequestWithRefresh:kPushRefresh baseView:nil];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self gifShowCell:tableView indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self gifShowCell:tableView indexPath:indexPath].rowHeight;
}

- (GifShowVideoTableViewCell1 *)gifShowCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    GifShowVideoTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"GifShowCell"];
    if (!cell) {
        cell=[[GifShowVideoTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GifShowCell"];
    }
    GifShowVideoModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    cell.delegate=self;
    if (cell.refresh) {
        [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
        cell.playBtn.selected = NO;
    }
    
    return cell;
}

#pragma mark - net
-(void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView
{
    self.baseView = baseView;
    _refresh=refresh;
    NSURL *url=[NSURL URLWithString:GifShowHeadURL];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    NSString *bodyString=@"";
    if (refresh == kPullRefresh) {
        static NSInteger i=0;
        NSInteger index=i++ / self.downArray.count;
        bodyString=self.downArray[index];
    }else if(refresh == kPushRefresh){
        static NSInteger i=0;
        NSInteger index=i++ / self.pageArray.count;
        bodyString=self.pageArray[index];
    }else{
        bodyString=GifShowTest;
    }
    NSData *bodyData=[bodyString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = bodyData;
    
    
    //最后开始加载post请求
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self performSelectorOnMainThread:@selector(parsingData:) withObject:data waitUntilDone:YES];
    }];
    [task resume];
}


- (void)parsingData:(NSData *)data
{
    if (!data) return;
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //
    GifShowOutModel *outModel=[[GifShowOutModel alloc] init];
    [outModel setValuesForKeysWithDictionary:dict];
    //
    NSArray *feedsArray=dict[@"feeds"];
    for (NSDictionary *d in feedsArray) {
        GifShowVideoModel *model=[[GifShowVideoModel alloc] init];
        model.thumbnail_url=d[@"thumbnail_url"];
        model.main_mv_url=d[@"main_mv_url"];
        model.time=d[@"time"];
        model.user_name=d[@"user_name"];
        model.main_url=d[@"main_url"];
        if (_refresh == kPullRefresh) {
            [self.dataSource insertObject:model atIndex:0];
        }else{
            [self.dataSource addObject:model];
        }
    }
    if (_baseView) {
        [_baseView endRefreshing];
        _baseView=nil;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [self.tableView reloadData];
}
#pragma mark - delegate

-(void)videoPlay:(BOOL)play videoCell:(FunnyVideoTableViewCell *)videoCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:videoCell];
    GifShowVideoModel *model = self.dataSource[indexPath.row];
    if ([WindowViewManager shareWindowViewManager].isWindowViewShow) {
        videoCell.playBtn.selected = NO;
        [[WindowViewManager shareWindowViewManager] videoPlayWithVideoUrlString:model.main_mv_url];
    }else{
        [[FunnyVideoPlayManage shareVideoManage] playVideoWithCell:videoCell urlString:model.main_mv_url play:play];
    }
}

-(void)playVideoOnWindow:(FunnyVideoTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    GifShowVideoModel *model = self.dataSource[indexPath.row];
    [[FunnyVideoPlayManage shareVideoManage] tableViewReload];
    [[WindowViewManager shareWindowViewManager] videoPlayCurrentTime:[FunnyVideoPlayManage shareVideoManage].currentTime videoUrlString:model.main_mv_url];
}

#pragma mark - lazy var

-(NSArray *)pageArray{
    if (!_pageArray) {
        _pageArray=[[NSArray alloc] initWithObjects:GifShowPage1,GifShowPage2,GifShowPage3,GifShowPage4,GifShowPage5,GifShowPage6, nil];
    }
    return _pageArray;
}

-(NSArray *)downArray{
    if (!_downArray) {
        _downArray=[[NSArray alloc] initWithObjects:GifShowDown1,GifShowDown2,GifShowDown3,GifShowDown4,GifShowDown5, nil];
    }
    return _downArray;
}
@end
