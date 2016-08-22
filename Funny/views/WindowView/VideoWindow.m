//
//  VideoWindow.m
//  Funny
//
//  Created by yanzhen on 16/8/1.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "VideoWindow.h"

//如果160的话beginPoint有时会出现错误
static CGFloat const MinWidth = 200.0;

@interface VideoWindow ()
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic) CGFloat scale;

@end

@implementation VideoWindow
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
        [self addGestureRecognizer:pin];
        self.clipsToBounds = YES;
        _scale = 1.0;
    }
    return self;
}

- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    _scale = pin.scale;
    if (_scale >= 1.0) {
        if (self.width * _scale > WIDTH) {
            _scale = WIDTH / self.width;
        }
    }else{
        if (self.width * _scale < MinWidth) {
            _scale = MinWidth / self.width;
        }
    }
    self.transform = CGAffineTransformScale(self.transform, _scale, _scale);
    pin.scale = 1.0;
    if (pin.state == UIGestureRecognizerStateEnded) {
        [self resetFrame];
    }
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _beginPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint nowPoint = [[touches anyObject] locationInView:self];
    float offsetX = nowPoint.x - _beginPoint.x;
    float offsetY = nowPoint.y - _beginPoint.y;
    float centerX = self.center.x + offsetX;
    float centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resetFrame];
}

- (void)resetFrame{
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    CGFloat width = self.width * _scale;
    CGFloat height = self.height * _scale;
    if(centerX < width / 2)
    {
        centerX = width / 2;
    }
    else if( centerX > WIDTH - width / 2)
    {
        centerX = WIDTH - width / 2;
    }
    
    if(centerY < height / 2)
    {
        centerY = height / 2;
    }
    else if(centerY > HEIGHT - height / 2)
    {
        centerY = HEIGHT - height / 2;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.center = CGPointMake(centerX, centerY);
    }];
}
#pragma mark - UI
-(void)setVideoView:(UIView *)videoView{
    if (_videoView == videoView) return;
    _videoView = videoView;
    self.frame = videoView.frame;
    [self addSubview:videoView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _videoView.frame = self.bounds;
}

@end
