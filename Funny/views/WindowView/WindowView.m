//
//  WindowView.m
//  Funny
//
//  Created by yanzhen on 16/7/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "WindowView.h"
#import "LayerDelegate.h"
#import "WindowLoadingView.h"
#import "AppDelegate.h"
#import "VideoWindow.h"

static CGFloat const TopLineHeight = 2;
static CGFloat const OtherHeight = TopLineHeight + 2;

@interface WindowView ()

@property (nonatomic, weak) UIVisualEffectView *effectView;
@property (nonatomic, strong) CALayer *yzLayer;
@property (nonatomic, strong) LayerDelegate *layerDelegate;
@property (nonatomic, weak) UIView *topLineView;
@property (nonatomic, weak) UIView *yzView;
@property (nonatomic, weak) UIButton *closeBtn;
@property (nonatomic, weak) UIButton *minOrMaxBtn;
@end

@implementation WindowView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - action
- (void)closeBtnClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(closeWindowView)]) {
        [_delegate closeWindowView];
    }
}

- (void)playBtnClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(videoPlayOrPause:)]) {
        [_delegate videoPlayOrPause:btn];
    }
}

- (void)minOrMaxClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    CGRect frame = CGRectZero;
    if (btn.selected) {
        CGFloat width = 240;
        CGFloat x = (self.width - width) * 0.5;
        frame = CGRectMake(x, 44, width, width / 4 * 3 + 4);
    }else{
        frame = CGRectMake(0, 0, WIDTH, WIDTH / 4 * 3 + 4);
    }
    AppDelegate *appDelegate = SharedAppDelegate;
    [UIView animateWithDuration:0.25 animations:^{
        appDelegate.videoWindow.frame = frame;
    }];
//    appDelegate.videoWindow.videoView = self.windowView;
    
}
#pragma mark - UI
- (void)configUI{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.userInteractionEnabled = NO;
    [self addSubview:effectView];
    _effectView = effectView;
    
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = YZColor(255, 155, 23);
    [self addSubview:topLineView];
    _topLineView = topLineView;
    
    UIImageView *mainImageView = [[UIImageView alloc] init];
    [self addSubview:mainImageView];
    _mainImageView = mainImageView;
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.progressTintColor = YZColor(255, 155, 23);
    [self addSubview:progressView];
    _progressView = progressView;
    
    UIView *yzView = [[UIView alloc] init];
    yzView.backgroundColor = [UIColor clearColor];
    _yzLayer = [CALayer layer];
    _yzLayer.backgroundColor = [UIColor clearColor].CGColor;
    _layerDelegate = [[LayerDelegate alloc] init];
    _layerDelegate.left = YES;
    _yzLayer.delegate = _layerDelegate;
    [yzView.layer addSublayer:_yzLayer];
    [_yzLayer setNeedsDisplay];
    [self addSubview:yzView];
    _yzView = yzView;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.backgroundColor =[UIColor clearColor];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"closeWindowView"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    _closeBtn = closeBtn;
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:[UIImage imageNamed:@"WindowViewPause"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];
    _playBtn = playBtn;
    
    UIButton *minOrMaxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minOrMaxBtn.backgroundColor = [UIColor grayColor];
    [minOrMaxBtn setTitle:@"小窗口" forState:UIControlStateNormal];
    [minOrMaxBtn setTitle:@"大窗口" forState:UIControlStateSelected];
    [minOrMaxBtn setTitleColor:YZColor(255, 155, 23) forState:UIControlStateNormal];
    minOrMaxBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [minOrMaxBtn addTarget:self action:@selector(minOrMaxClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:minOrMaxBtn];
    _minOrMaxBtn = minOrMaxBtn;
    
    WindowLoadingView *loadingView = [[WindowLoadingView alloc] init];
    YZWeakSelf(self)
    loadingView.block = ^(){
        if ([weakself.delegate respondsToSelector:@selector(loadingViewDismissForFail)]) {
            [weakself.delegate loadingViewDismissForFail];
        }
    };
    loadingView.hidden = YES;
    [self addSubview:loadingView];
    _loadingView = loadingView;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    _effectView.frame = self.bounds;
    _topLineView.frame = CGRectMake(0, 0, width, TopLineHeight);
    _progressView.frame = CGRectMake(0, height - 2, width, 2);
    _mainImageView.frame = CGRectMake(0, TopLineHeight, width, height - OtherHeight);
    _yzView.frame = CGRectMake(0, TopLineHeight, width, height - OtherHeight);
    _yzLayer.frame = _yzView.bounds;
    _closeBtn.frame = CGRectMake(width - 27.5, TopLineHeight + 2.5, 25, 25);
    CGFloat b = 1.5;
    CGFloat closeBtnWidth = 30;
    CGFloat minOrMaxBtnWidth = 50;
    CGFloat minOrMaxBtnFont = 15;
    if (_minOrMaxBtn.selected) {
        b = 0.8;
        closeBtnWidth = 25;
        minOrMaxBtnWidth *= 0.7;
        minOrMaxBtnFont = 11;
    }
    _closeBtn.frame = CGRectMake(width - 2.5 - closeBtnWidth, TopLineHeight + 2.5, closeBtnWidth, closeBtnWidth);
    
    _playBtn.frame = CGRectMake(0, 0, 70 * b, 70 * b);
    _playBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    _minOrMaxBtn.frame = CGRectMake(width - minOrMaxBtnWidth, height - 2 - minOrMaxBtnWidth * 0.5, minOrMaxBtnWidth, minOrMaxBtnWidth * 0.5);
    _minOrMaxBtn.titleLabel.font = [UIFont systemFontOfSize:minOrMaxBtnFont];
    
    _loadingView.frame = CGRectMake(0, 0, 70, 70);
    _loadingView.center = CGPointMake(width * 0.5, height * 0.5);
    
    for (CALayer *layer in _mainImageView.layer.sublayers) {
        layer.frame = _mainImageView.bounds;
    }
}
@end
