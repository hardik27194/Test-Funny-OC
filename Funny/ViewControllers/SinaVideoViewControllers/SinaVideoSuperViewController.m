//
//  SinaVideoSuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

NSString *const SinaVideoDefaultHeadURL = @"http://api.sina.cn/sinago/list.json?uid=aa31ca8b95d9be1d&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&imei=864312021030956&from=6048295012&connection_type=2&chwm=14010_0001&AndroidID=54311f315451935f5018874c7a46f88e&v=1&s=20&IMEI=aee8dee79e22198eedfc9a194387dbf5&p=";
NSString *const SinaVideoDefaultMiddleURL = @"1&MAC=8334eea73efc71c74369fd0f31a64c5b&channel=video_";

#import "SinaVideoSuperViewController.h"
#import "SuperWebViewController.h"
#import "SinaVideosTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface SinaVideoSuperViewController ()<SinaVideoPlayClickDelegate>
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayerLayer *layer;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIButton *currentPlayButton;
//
@property (strong, nonatomic) UIProgressView *currentProgressView;
@end

@implementation SinaVideoSuperViewController
{
    UIImageView *_layerImageView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.currentPlayButton.hidden) {
        self.currentPlayButton.hidden=NO;
        if (_layerImageView.layer.sublayers.count>=1) {
            [self.currentProgressView setProgress:0.0f animated:YES];
            [_layerImageView.layer.sublayers[1] removeFromSuperlayer];
        }
        //复用时会调用，
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.player replaceCurrentItemWithPlayerItem:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 275.0;
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
            SinaVideoModel *model=[[SinaVideoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if (!model.kpic) {
                continue;
            }
            if (refresh == kPullRefresh) {
                if (j==0) {
                    SinaVideoModel *testModel=self.dataSource[0];
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
        [self.tableView reloadData];
    } failed:^(NSString *errorMsg) {
        YZLog(@"%@",errorMsg);
    }];
}
-(NSString *)requestURLString:(eRefresh)refresh
{
    static int i=2;
    if (refresh == kPushRefresh) {
        NSString *urlString=[SinaVideoDefaultHeadURL stringByAppendingFormat:@"%d",i++];
        urlString = [urlString stringByAppendingString:SinaVideoDefaultMiddleURL];
        return [urlString stringByAppendingString:self.titleName];
    }else{
        NSString *urlString=[SinaVideoDefaultHeadURL stringByAppendingString:@"1"];
        urlString = [urlString stringByAppendingString:SinaVideoDefaultMiddleURL];
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
    SinaVideoModel *model=self.dataSource[indexPath.row];
    SinaVideosTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SinaVideoCell];
    if (!cell) {
        cell=[[SinaVideosTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SinaVideoCell];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    cell.delegate=self;
    cell.playButton.tag=5000+indexPath.row;
    if (cell.playButton.hidden) {
        [self playInterrupt];
    }
    cell.playButton.hidden=NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SinaVideoModel *model=self.dataSource[indexPath.row];
    SuperWebViewController *vc=[[SuperWebViewController alloc] initWithUrlString:model.link];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - video
-(void)playButtonClick:(UIButton *)button
{
    SinaVideosTableViewCell *cell=(SinaVideosTableViewCell *)button.superview.superview;
    if (self.currentPlayButton) {
        self.currentPlayButton.hidden=NO;
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.currentProgressView setProgress:0.0f animated:YES];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.player replaceCurrentItemWithPlayerItem:nil];
        //[_layerImageView.layer.sublayers[1] removeFromSuperlayer];
        
        [_layerImageView.layer.sublayers[1] removeFromSuperlayer];
    }
    self.currentProgressView=cell.progressView;
    button.hidden=YES;
    self.currentPlayButton=button;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    SinaVideoModel *model=self.dataSource[indexPath.row];
    NSURL *videoUrl=[NSURL URLWithString:model.video_info[@"url"]];
    self.playerItem=[AVPlayerItem playerItemWithURL:videoUrl];
    if (self.playerItem) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
            self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            self.layer.frame = cell.mainImageView.bounds;
            self.layer.backgroundColor = [UIColor blackColor].CGColor;
            _layerImageView=cell.mainImageView;
            [_layerImageView.layer addSublayer:self.layer];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
            [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            [self.player play];
        });
    }
    
}
- (void)playEnd
{
    self.currentPlayButton.hidden=NO;
    if (_layerImageView.layer.sublayers.count>=1) {
        [_layerImageView.layer.sublayers[1] removeFromSuperlayer];
        [self.currentProgressView setProgress:0.0f animated:YES];
    }
    //复用时会调用，??????? 不知道？？？？？？
    static int i=0;
    i++;
    if (1 == i) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        self.currentPlayButton=nil;
    }
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.player replaceCurrentItemWithPlayerItem:nil];
}
- (void)playInterrupt
{
    if (!self.currentPlayButton) {
        return;
    }
    if (self.currentPlayButton.hidden) {
        self.currentPlayButton.hidden=NO;
    }
    if (_layerImageView.layer.sublayers.count>=1) {
        [_layerImageView.layer.sublayers[1] removeFromSuperlayer];
    }
    [self.currentProgressView setProgress:0.0f animated:YES];
    //复用时会调用，
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.player replaceCurrentItemWithPlayerItem:nil];
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer=[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)updateProgress
{
    CGFloat currntTime=self.player.currentTime.value/self.player.currentTime.timescale;
    CGFloat time=self.playerItem.duration.value/self.playerItem.duration.timescale*1.0;
    [self.currentProgressView setProgress:currntTime/time animated:YES];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        if (self.playerItem.status == AVPlayerStatusReadyToPlay) {
            [self.timer setFireDate:[NSDate distantPast]];
        }else if(self.playerItem.status == AVPlayerStatusFailed){
            [self.timer setFireDate:[NSDate distantFuture]];
        }
    }
}

@end
