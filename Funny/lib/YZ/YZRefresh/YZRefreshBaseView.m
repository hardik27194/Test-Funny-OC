//
//  YZRefreshBaseView.m
//  YZRefreshView
//
//  Created by yanzhen on 16/2/24.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "YZRefreshBaseView.h"
#import "YZRefreshExtend.h"

@interface YZRefreshBaseView ()
@property (nonatomic, assign) YZRefreshStatus status;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *yzAnimationImages;

- (YZRefreshViewType)refreshViewType;
- (CGFloat)beginRefreshY;
@end

@implementation YZRefreshBaseView
{
    BOOL _hasInitInset;
}
- (void)setFrame:(CGRect)frame{
    frame.size.height = YZRefreshViewHeight;
    [super setFrame:frame];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollViewInitInset = scrollView.contentInset;
    [_scrollView removeObserver:self forKeyPath:YZRefreshContentOffset context:nil];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:YZRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    int viewType = [self refreshViewType];
    CGFloat originY = 0;
    if (YZRefreshFooter == viewType) {
        originY = MAX(self.scrollView.frame.size.height - _scrollViewInitInset.top - _scrollViewInitInset.bottom, self.scrollView.contentSize.height);
    }else{
        originY = viewType * YZRefreshViewHeight;
    }
    self.frame = CGRectMake(0, originY, YZSCREENWIDTH, -viewType * YZRefreshViewHeight);
    [_scrollView addSubview:self];
}
#pragma mark - Animation
- (void)backToIdentity{
    
    UIEdgeInsets inset = self.scrollView.contentInset;
    if (self.refreshViewType == YZRefreshFooter) {
        inset.bottom = _scrollViewInitInset.bottom;
    }else{
        inset.top = _scrollViewInitInset.top;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = inset;
    }];
}

- (void)keepAnimation{
    UIEdgeInsets inset = self.scrollView.contentInset;
    if (self.refreshViewType == YZRefreshHeader) {
        inset.top = _scrollViewInitInset.top + YZRefreshViewHeight;
    }else{
        CGFloat bottom = YZRefreshViewHeight + _scrollViewInitInset.bottom;
        CGFloat h = self.scrollView.frame.size.height - _scrollViewInitInset.bottom - _scrollViewInitInset.top;
        CGFloat deltaH = self.scrollView.contentSize.height - h;
        if (deltaH < 0) { // 如果内容高度小于view的高度
            bottom -= deltaH;
        }
        inset.bottom = bottom;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = inset;
    }];
}

- (void)setRefreshStatus:(YZRefreshStatus)status{
    if (self.status != YZRefreshStatusRefreshing) {
        // 存储当前的contentInset
        _scrollViewInitInset = self.scrollView.contentInset;
    }
    if (self.status == status) return;
    //必须写下这里
    self.status = status;
    switch (status) {
        case YZRefreshStatusNormal:
        {
            if (self.imageView.isAnimating) {
                [self.imageView stopAnimating];
            }
            self.imageView.image = [self normalUseImage];
            [self backToIdentity];
            if (self.endRefreshingBlock) {
                self.endRefreshingBlock(self);
            }
            break;
        }
        case YZRefreshStatusPulling:
            
            break;
        case YZRefreshStatusRefreshing:
        {
            self.imageView.animationImages = [self animationUseImages];
            self.imageView.animationDuration = YZRefreshAnimationDuration;
            [self.imageView startAnimating];
            [self keepAnimation];
            if (self.beginRefreshingBlock) {
                self.beginRefreshingBlock(self);
            }
            break;
        }
        default:
            break;
    }
}
#pragma mark - keyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"contentOffset"] || YZRefreshStatusRefreshing == self.status) return;
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    int viewType = [self refreshViewType];
    CGFloat offsetY = self.scrollView.contentOffset.y * viewType;
    if (self.scrollView.isDragging) {
        CGFloat y = YZRefreshViewHeight + self.beginRefreshY;
        if (self.status == YZRefreshStatusPulling && offsetY <= y) {
            [self setRefreshStatus:YZRefreshStatusNormal];
        }else if (self.status == YZRefreshStatusNormal && offsetY > y){
            [self setRefreshStatus:YZRefreshStatusPulling];
        }
    }else{
        if (self.status == YZRefreshStatusPulling) {
            
            [self setRefreshStatus:YZRefreshStatusRefreshing];
        }
    }
    
}

#pragma mark - Image
- (UIImage *)normalUseImage{
    return self.normalImage ? self.normalImage : [UIImage imageNamed:YZRefreshNormalImageName];
}

- (NSArray *)animationUseImages{
    return self.animationImages ? self.animationImages : self.yzAnimationImages;
}

- (NSMutableArray *)yzAnimationImages{
    if (!_yzAnimationImages) {
        _yzAnimationImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 4; i++) {
            NSString *imageName = [YZRefreshBundleImageName stringByAppendingFormat:@"%lu",i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [_yzAnimationImages addObject:image];
        }
    }
    return _yzAnimationImages;
}
#pragma mark - UI
- (YZRefreshViewType)refreshViewType{
    return YZRefreshHeader;
}
- (CGFloat)beginRefreshY{return 0;}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 18, 31.5,42.5)];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        [self setRefreshStatus:YZRefreshStatusNormal];
    }
    return _imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_hasInitInset) {
        _scrollViewInitInset = _scrollView.contentInset;
        
        [self observeValueForKeyPath:YZRefreshContentSize ofObject:nil change:nil context:nil];
        
        _hasInitInset = YES;
        
        if (_status == YZRefreshStatusWillRefreshing) {
            [self setStatus:YZRefreshStatusRefreshing];
        }
    }

    CGPoint point = CGPointMake(YZSCREENWIDTH / 2, self.imageView.center.y);
    self.imageView.center = point;
}
#pragma mark - refresh
- (BOOL)isRefreshing{
    return YZRefreshStatusRefreshing == self.status;
}
- (void)beginRefreshing{
    if (self.window) {
        [self setRefreshStatus:YZRefreshStatusRefreshing];
    } else {
        self.status = YZRefreshStatusWillRefreshing;
    }
}
- (void)endRefreshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setRefreshStatus:YZRefreshStatusNormal];
    });
}

- (void)free
{
    [_scrollView removeObserver:self forKeyPath:YZRefreshContentOffset];
}
- (void)removeFromSuperview
{
    [self free];
    _scrollView = nil;
    [super removeFromSuperview];
}
@end
