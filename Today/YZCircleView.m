//
//  YZCircleView.m
//  test
//
//  Created by yanzhen on 16/10/18.
//  Copyright © 2016年 v2tech. All rights reserved.
//
#import "YZCircleView.h"

@interface YZCircleView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@end

@implementation YZCircleView
- (instancetype)initWithRadius:(CGFloat)radius frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat lineWidth = 2.0;
        
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.frame = self.bounds;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = [UIColor grayColor].CGColor;
        _circleLayer.opacity = 0.25;//背景圆环的背景透明度
        _circleLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:_circleLayer];
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        _circleLayer.path = circlePath.CGPath;
        _circleLayer.lineWidth = lineWidth;
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor = [UIColor colorWithRed:1.0 green:133/255.0 blue:25/255.0 alpha:1.0].CGColor;
        _progressLayer.lineCap = kCAFillRuleNonZero;
        _progressLayer.strokeEnd = 0.0;
        _progressLayer.lineWidth = lineWidth;
        [self.layer addSublayer:_progressLayer];
        
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];//-210到30的path
        _progressLayer.path = path1.CGPath;
        
        CGFloat labelHeight = 25.0;
        if (radius < (labelHeight + lineWidth)) {
            labelHeight = radius - lineWidth;
        }
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5 - radius + lineWidth, height * 0.5 - labelHeight, 2 * radius - 2 * lineWidth, labelHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:104/255.0 green:99/255.0 blue:107/255.0 alpha:1.0];
        _titleLabel.text = @"";
        [self addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5 - radius + lineWidth, height * 0.5, 2 * radius - 2 * lineWidth, labelHeight)];
        _subTitleLabel.textColor = [UIColor colorWithRed:14/255.0 green:110/255.0 blue:251/255.0 alpha:1.0];
        _subTitleLabel.font = [UIFont systemFontOfSize:15.0];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = @"";
        [self addSubview:_subTitleLabel];
        
    }
    return self;
}
#pragma mark - set

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    progress = progress < 0.0 ? 0.0 : progress;
    progress = progress > 1.0 ? 1.0 : progress;
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
}

-(void)setTitleFontSize:(CGFloat)titleFontSize{
    _titleFontSize = titleFontSize;
    _titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
}

-(void)setSubTitleFontSize:(CGFloat)subTitleFontSize{
    _subTitleFontSize = subTitleFontSize;
    _subTitleLabel.font = [UIFont systemFontOfSize:subTitleFontSize];
}
@end
