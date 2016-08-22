//
//  ShotPartScreenView.m
//  Funny
//
//  Created by yanzhen on 15/12/8.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "ShotPartScreenView.h"
#import <QuartzCore/QuartzCore.h>

@interface ShotPartScreenView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGRect shotRect;

@end
@implementation ShotPartScreenView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    [self prepareShapeLayer];
    [self prepareUI];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
    
    
}
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    static CGPoint startPoint;
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        self.shapeLayer.path = NULL;
        
        startPoint = [pan locationInView:self];
        if (startPoint.x<=20) {
            startPoint.x=1.0f;
        }
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [pan locationInView:self];
        CGPathRef path = CGPathCreateWithRect(CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y), NULL);
        self.shotRect=CGRectMake(startPoint.x, startPoint.y, currentPoint.x - startPoint.x, currentPoint.y - startPoint.y);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }

}
- (void)sureButtonAction:(UIButton *)button
{
    //上边界截图有问题，稍作改动
    CGRect myRect=CGRectMake(_shotRect.origin.x, _shotRect.origin.y-5, _shotRect.size.width, _shotRect.size.height+5);
    if (_block) {
        _block(YES,myRect);
    }
}
- (void)cancelButtonClick:(UIButton *)button
{
    CGRect rect=CGRectMake(0, 0, 0, 0);
    if (_block) {
        _block(NO,rect);
    }
}
- (void)prepareUI
{
    UIView *smallView=[[UIView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-35, WIDTH-20, 35)];
    smallView.backgroundColor=[UIColor redColor];
    smallView.layer.cornerRadius=5.0f;
    //smallView.alpha=0.2;
    [self addSubview:smallView];
    //
    UIButton *sureButton=[[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-60, self.bounds.size.height-30, 40, 25)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(20, self.bounds.size.height-30, 40, 25)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];

}
- (void)prepareShapeLayer
{
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth   = 2;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor   = [[UIColor grayColor] colorWithAlphaComponent:0.15f].CGColor;
    self.shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], nil];
    
    CGPathRef path = CGPathCreateWithRect(CGRectInset(self.bounds,
                                                      20,
                                                      150),
                                          NULL);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:self.shapeLayer];
}

@end
