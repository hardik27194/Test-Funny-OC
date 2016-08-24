//
//  WindowViewManager.m
//  Funny
//
//  Created by yanzhen on 16/7/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "WindowViewManager.h"
#import <AVFoundation/AVFoundation.h>
#import "WindowView.h"
#import "WindowLoadingView.h"
#import "VideoWindow.h"
#import "AppDelegate.h"

@interface WindowViewManager ()<WindowViewDelegate>
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) WindowView *windowView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic) CMTime time;

@property (nonatomic, assign) BOOL isPlayEnd;
@property (nonatomic, assign) BOOL enterBackground;
@property (nonatomic, assign) BOOL isPause;
@property (nonatomic, assign) BOOL isPlaying;


@end

@implementation WindowViewManager
MShareInstance(WindowViewManager)
- (void)videoPlayCurrentTime:(CMTime)time videoUrlString:(NSString *)urlString{
    _urlString = urlString;
    _time = time;
    AppDelegate *appDelegate = SharedAppDelegate;
    appDelegate.videoWindow.videoView = self.windowView;
    [appDelegate.videoWindow makeKeyAndVisible];
    self.windowView.hidden = NO;
    [self startPlayVideo:urlString];
}

- (void)videoPlayWithVideoUrlString:(NSString *)urlString{
    _urlString = urlString;
    self.windowView.hidden = NO;
    [self startPlayVideo:urlString];
}

- (void)startPlayVideo:(NSString *)urlString{
    
    self.windowView.playBtn.selected = NO;
    self.windowView.loadingView.hidden = NO;
    self.windowView.loadingView.tipLabel.hidden = YES;
    [self.windowView.loadingView.indicator startAnimating];
    _isPause = NO;
    
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isPlayEnd && self.player.currentItem) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
            [self.player replaceCurrentItemWithPlayerItem:playerItem];
        }else{
            self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
            self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            self.playerLayer.backgroundColor = [UIColor clearColor].CGColor;
            self.isPlayEnd = YES;
        }
        self.playerLayer.frame = self.windowView.mainImageView.bounds;
        [self.windowView.mainImageView.layer addSublayer:self.playerLayer];
        [self addNotifiWithPlayerItem:playerItem];
        [self.player play];
        _isPlaying = YES;
    });
}

#pragma mark - WindowViewDelegate
-(void)closeWindowView{
    if (self.player.rate || _isPlaying) {
        [self.player pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
    _windowView.hidden = YES;
    AppDelegate *appDelegate = SharedAppDelegate;
    appDelegate.videoWindow.hidden = YES;
    [appDelegate.window makeKeyAndVisible];
//    _windowView = nil;
}

- (void)videoPlayOrPause:(UIButton *)playBtn{
    
    void (^block)(BOOL pause) = ^(BOOL pause){
        _isPause = pause;
        playBtn.selected = pause;
        _isPlaying = !pause;
        if (pause) {
            [self.player pause];
            self.timer.fireDate = [NSDate distantFuture];
        }else{
            [self.player play];
            self.timer.fireDate = [NSDate distantPast];
        }
    };
    
    if (_isPlaying) {
        block(YES);
    }else{
        if (_isPause) {
            block(NO);
        }else{
            [self startPlayVideo:_urlString];
        }
    }
}

-(void)loadingViewDismissForFail{
    self.windowView.playBtn.selected = YES;
}

#pragma mark - Method
- (void)playVideoEnd{
    _isPlaying = NO;
    self.windowView.playBtn.selected = YES;
    self.timer.fireDate = [NSDate distantFuture];
    [self.windowView.progressView setProgress:0.0 animated:NO];
}

- (void)didEnterBackground{
    if (self.player.rate || _isPlaying) {
        [self.player pause];
        _enterBackground = YES;
    }
}

- (void)didBecomeActive{
    if (_enterBackground) {
        [self.player play];
        _isPlaying = YES;
        _enterBackground = NO;
    }
}


- (void)updateProgress{
    CGFloat currntTime=self.player.currentTime.value/self.player.currentTime.timescale;
    CGFloat time=self.player.currentItem.duration.value/self.player.currentItem.duration.timescale*1.0;
    [self.windowView.progressView setProgress:currntTime/time animated:YES];
}


#pragma mark - Notifi
- (void)addNotifiWithPlayerItem:(AVPlayerItem *)item{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //没考虑删除通知的情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = self.player.currentItem;
        if (item.status == AVPlayerStatusReadyToPlay) {
            self.timer.fireDate = [NSDate distantPast];
            [self.windowView.loadingView.indicator stopAnimating];
            self.windowView.loadingView.hidden = YES;
#pragma mark - 快进的方式
//            YZWeakSelf(self)
//            [self.player seekToTime:_time completionHandler:^(BOOL finished) {
//                [weakself.player play];
//            }];
        }else if(item.status == AVPlayerStatusFailed){
            self.windowView.loadingView.tipLabel.hidden = NO;
            self.timer.fireDate = [NSDate distantFuture];
            _isPlaying = NO;
            self.isPlayEnd = NO;
            [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        }
    }
    
}
#pragma mark - lazy var
-(BOOL)isWindowViewShow{
    return !self.windowView.hidden;
}

-(WindowView *)windowView{
    if (!_windowView) {
        _windowView = [[WindowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH / 4 * 3 + 4)];
        _windowView.hidden = YES;
        _windowView.delegate = self;
    }
    return _windowView;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
@end
