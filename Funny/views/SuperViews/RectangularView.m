//
//  RectangularView.m
//  line
//
//  Created by yanzhen on 15/10/23.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "RectangularView.h"

#define LineWidth 5
#define LabelHeight 40
#define LabelWidth 40
#define BorderSpace 13
#define LabelFont 13
@interface RectangularView ()
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UILabel *label3;
@property (strong, nonatomic) UILabel *label4;
@property (assign, nonatomic) eMoveType moveType;
@end
@implementation RectangularView
{
    CGPoint first;
    CGPoint second;
    CGPoint third;
    CGPoint forth;
    CGPoint five;
    BOOL isInIt;
    CGPoint start;
    CGPoint end;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self confUI];
        [self awake];
    }
    return self;
}
- (void)confUI
{
    UIView *smallView=[[UIView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-35, WIDTH-20, 35)];
    smallView.backgroundColor=[UIColor redColor];
    smallView.layer.cornerRadius=5.0f;
    //smallView.alpha=0.2;
    [self addSubview:smallView];
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
- (void)sureButtonAction:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(shotOrNotShot: frame:)]) {
        //考虑不能到达边界的问题
        if (first.x<=20) {
            first.x=0;
        }
        if (third.x >= WIDTH-20) {
            third.x=WIDTH;
        }
        [_delegate shotOrNotShot:YES frame:CGRectMake(first.x, first.y, third.x-first.x, second.y-first.y)];
    }
}
- (void)cancelButtonClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(shotOrNotShot: frame:)]) {
        [_delegate shotOrNotShot:NO frame:CGRectMake(0, 0, 0, 0)];
    }
}
-(void)awake
{
    first=CGPointMake(50, 200);
    second=CGPointMake(50, 350);
    third=CGPointMake(350, 350);
    forth=CGPointMake(350, 200);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.设置绘图信息/拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 3.设置一个起点
    [path moveToPoint:first];
    
    // 4.添加一条直线到一个点
    [path addLineToPoint:second];
    
    // 5.添加一条直线到一个点
    [path addLineToPoint:third];
    
    [path addLineToPoint:forth];
    [path closePath];
    //[path addLineToPoint:first];
    // 5.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, LineWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    [[UIColor blueColor] set];
    // 6.把上下文渲染到视图
    CGContextStrokePath(ctx);
    
    [self addLabel];
    // stroke:描边
    // fill:  填充
    
    
}

- (void)addLabel
{
    CGFloat width=(third.x-first.x)/2;
    CGFloat height=(second.y-first.y)/2;
    self.label1.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
    self.label1.center=CGPointMake(first.x-LabelWidth/2+LineWidth*3, first.y+height-LabelHeight/2+LineWidth*4);
    self.label2.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
    self.label2.center=CGPointMake(second.x+width-LabelWidth/2+LineWidth*4, second.y+LabelHeight/2-3*LineWidth);
    self.label3.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
    self.label3.center=CGPointMake(third.x+LabelWidth/2-LineWidth*3, third.y-height-LabelHeight/2+4*LineWidth);
    self.label4.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
    self.label4.center=CGPointMake(first.x+width-LabelWidth/2+4*LineWidth, first.y-LabelHeight/2+3*LineWidth);
    
}
#pragma mark - touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if (point.x>=first.x && point.y<=third.y && point.x<=forth.x && point.y >= first.y) {
        isInIt=YES;
        start=point;
    }else{
        isInIt=NO;
        if (CGRectContainsPoint(_label1.frame, point)) {
            self.moveType=kMoveLeft;
        }else if (CGRectContainsPoint(_label2.frame, point)){
            self.moveType=kMoveDown;
        }else if (CGRectContainsPoint(_label3.frame, point)){
            self.moveType=kMoveRight;
        }else if (CGRectContainsPoint(_label4.frame, point)){
            self.moveType=kMoveUp;
        }else{
            self.moveType=kMoveUnknow;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if (isInIt) {
        end=point;
        [self move];
    }else{
        if (self.moveType == kMoveLeft) {
            [self moveLeft:point];
        }else if (self.moveType == kMoveDown){
            [self moveDown:point];
        }else if (self.moveType == kMoveRight){
            [self moveRight:point];
        }else if (self.moveType == kMoveUp){
            [self moveUp:point];
        }else{
            return;
        }
    }
}
#pragma mark - move
- (void)moveLeft:(CGPoint)point
{
    if (point.x<=BorderSpace) {
        point.x=BorderSpace;
    }
    first.x=point.x;
    second.x=point.x;
    [self setNeedsDisplay];
}
- (void)moveDown:(CGPoint)point
{
    if (point.y>=self.bounds.size.height-BorderSpace) {
        point.y=self.bounds.size.height-BorderSpace;
    }
    second.y=point.y;
    third.y=point.y;
    [self setNeedsDisplay];
}
- (void)moveRight:(CGPoint)point
{
    if (point.x>=self.bounds.size.width-BorderSpace) {
        point.x=self.bounds.size.width-BorderSpace;
    }
    third.x=point.x;
    forth.x=point.x;
    [self setNeedsDisplay];
}
- (void)moveUp:(CGPoint)point
{
    if (point.y<=BorderSpace) {
        point.y=BorderSpace;
    }
    first.y=point.y;
    forth.y=point.y;
    [self setNeedsDisplay];
}
- (void)move{
    CGFloat x=end.x-start.x;
    CGFloat y=end.y-start.y;
    start=end;
    first.x+=x;
    first.y+=y;
    second.x+=x;
    second.y+=y;
    third.x+=x;
    third.y+=y;
    forth.x+=x;
    forth.y+=y;
    CGFloat width=third.x-first.x;
    CGFloat height=second.y-first.y;
    if (first.x<BorderSpace) {
        first.x=BorderSpace;
        second.x=BorderSpace;
        third.x=width+BorderSpace;
        forth.x=width+BorderSpace;
    }
    if (first.y<BorderSpace) {
        first.y=BorderSpace;
        second.y=height+BorderSpace;
        third.y=height+BorderSpace;
        forth.y=BorderSpace;
    }
    if (third.x>self.bounds.size.width-BorderSpace) {
        width+=BorderSpace;
        first.x=self.bounds.size.width-width;
        second.x=self.bounds.size.width-width;
        third.x=self.bounds.size.width-BorderSpace;
        forth.x=self.bounds.size.width-BorderSpace;
    }
    if (third.y>self.bounds.size.height-BorderSpace) {
        height+=BorderSpace;
        first.y=self.bounds.size.height-height;
        second.y=self.bounds.size.height-BorderSpace;
        third.y=self.bounds.size.height-BorderSpace;
        forth.y=self.bounds.size.height-height;
    }
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
#pragma mark - lazy loading
-(UILabel *)label1
{
    if (!_label1) {
        _label1=[[UILabel alloc] init];
        _label1.text=@"⬅️";
        _label1.textAlignment=NSTextAlignmentCenter;
        _label1.font=[UIFont systemFontOfSize:LabelFont];
        _label1.userInteractionEnabled=YES;
        [self addSubview:_label1];
    }
    return _label1;
}
-(UILabel *)label2
{
    if (!_label2) {
        _label2=[[UILabel alloc] init];
        _label2.text=@"⬇️";
        _label2.textAlignment=NSTextAlignmentCenter;
        _label2.font=[UIFont systemFontOfSize:LabelFont];
        _label2.userInteractionEnabled=YES;
        [self addSubview:_label2];
    }
    return _label2;
}
-(UILabel *)label3
{
    if (!_label3) {
        _label3=[[UILabel alloc] init];
        _label3.text=@"➡️";
        _label3.textAlignment=NSTextAlignmentCenter;
        _label3.font=[UIFont systemFontOfSize:LabelFont];
        _label3.userInteractionEnabled=YES;
        [self addSubview:_label3];
    }
    return _label3;
}

-(UILabel *)label4
{
    if (!_label4) {
        _label4=[[UILabel alloc] init];
        _label4.text=@"⬆️";
        _label4.textAlignment=NSTextAlignmentCenter;
        _label4.font=[UIFont systemFontOfSize:LabelFont];
        _label4.userInteractionEnabled=YES;
        [self addSubview:_label4];
    }
    return _label4;
}


@end
