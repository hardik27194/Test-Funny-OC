//
//  FunnyVideoPlayManage.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyVideoPlayManage.h"
#import "FunnyVideoTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "CALayerDelegate.h"

@interface FunnyVideoPlayManage ()
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) BOOL isPlayEnd;
@property (nonatomic, assign) BOOL enterBackground;
@property (nonatomic, weak) FunnyVideoTableViewCell *videoCell;
@property (nonatomic, strong) CALayerDelegate *layerDelegate;

@end

@implementation FunnyVideoPlayManage
MShareInstance(VideoManage);

-(void)playVideoWithCell:(FunnyVideoTableViewCell *)cell urlString:(NSString *)urlString play:(BOOL)play{
    if (![self startPlayNewAV:urlString play:play]) {
        return;
    }
    [self playVideoInterrupt];
    _urlString = urlString;
    self.videoCell = cell;
    _videoCell.isPause = NO;
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
            self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
            self.isPlayEnd = YES;
        }
        self.playerLayer.frame = cell.mainImageView.bounds;
        [cell.mainImageView.layer addSublayer:self.playerLayer];
        
        CALayer *layer = [CALayer layer];
        layer.frame = cell.mainImageView.bounds;
        layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layerDelegate.rightSpace = cell.rightSpace;
        layer.delegate = self.layerDelegate;
        [layer setNeedsDisplay];
        [cell.mainImageView.layer addSublayer:layer];
        
        [self addNotifiWithPlayerItem:playerItem];
        [self.player play];
    });
}

- (BOOL)startPlayNewAV:(NSString *)urlString play:(BOOL)play{
    BOOL start = YES;
    if ([_urlString isEqualToString:urlString]) {
        if (play) {
            _videoCell.isPause = NO;
            [self.player play];
            self.timer.fireDate = [NSDate distantPast];
        }else{
            _videoCell.isPause = YES;
            [self.player pause];
            self.timer.fireDate = [NSDate distantFuture];
        }
        start = NO;
    }
    return start;
}

-(void)tableViewReload{
    [self playVideoInterrupt];
}

- (void)playVideoInterrupt{
    _urlString = nil;
    if (self.player.currentItem) {
        [self.player pause];
        [self playVideoEnd];
    }
    
    if (_videoCell.isPause) {
        [self playVideoEnd];
        _videoCell.isPause = NO;
    }
//    else{
//        if (self.videoCell.mainImageView.layer.sublayers.count > 1) {
//            [self.videoCell.mainImageView.layer.sublayers.lastObject removeFromSuperlayer];
//            //[self.videoCell.mainImageView.layer.sublayers[1] removeFromSuperlayer];
//        }
//    }
}

- (void)playVideoEnd{
    self.videoCell.playBtn.selected = NO;
    if (self.videoCell.mainImageView.layer.sublayers.count > 1) {
        [self.videoCell.mainImageView.layer.sublayers[0] removeFromSuperlayer];
        [self.videoCell.mainImageView.layer.sublayers[1] removeFromSuperlayer];
    }
    [self.videoCell.progressView setProgress:0.0 animated:NO];
    self.timer.fireDate = [NSDate distantFuture];
    self.videoCell = nil;
    self.urlString = nil;
}

- (void)addNotifiWithPlayerItem:(AVPlayerItem *)item{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //没考虑删除通知的情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)didEnterBackground{
    if (self.player.rate) {
        [self.player pause];
        [self willEnterBackground:YES];
    }
}

- (void)didBecomeActive{
    if (_enterBackground) {
        [self.player play];
        [self willEnterBackground:NO];
    }
}

- (void)willEnterBackground:(BOOL)status{
    _videoCell.playBtn.selected = !status;
    _videoCell.isPause = status;
    _enterBackground = status;
}

- (void)updateProgress{
    CGFloat currntTime=self.player.currentTime.value/self.player.currentTime.timescale;
    CGFloat time=self.player.currentItem.duration.value/self.player.currentItem.duration.timescale*1.0;
    [self.videoCell.progressView setProgress:currntTime/time animated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = self.player.currentItem;
        if (item.status == AVPlayerStatusReadyToPlay) {
            self.timer.fireDate = [NSDate distantPast];
        }else if(item.status == AVPlayerStatusFailed){
            self.timer.fireDate = [NSDate distantFuture];
            self.isPlayEnd = NO;
            [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        }
    }

}

#pragma mark - lazy var

-(CMTime)currentTime{
    return self.player.currentTime;
}

-(CALayerDelegate *)layerDelegate{
    if (!_layerDelegate) {
        _layerDelegate = [[CALayerDelegate alloc] init];
    }
    return _layerDelegate;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
@end
