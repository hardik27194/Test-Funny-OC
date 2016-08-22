//
//  LockView.m
//  Funny
//
//  Created by yanzhen on 15/10/27.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "LockView.h"

#define LockViewButtonTag 1000000
@interface LockView ()
@property (strong, nonatomic) NSMutableArray *buttonsArray;
@property (assign, nonatomic) CGPoint movePoint;
@end
@implementation LockView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self isFirstDraw];
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    UIButton *touchButton=[self buttonWithPoint:point];
    if (touchButton && !touchButton.selected) {
        touchButton.selected=YES;
        [self.buttonsArray addObject:touchButton];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    _movePoint=[touch locationInView:self];
    UIButton *moveToButton=[self buttonWithPoint:_movePoint];
    if (moveToButton && !moveToButton.selected) {
        moveToButton.selected=YES;
        [self.buttonsArray addObject:moveToButton];
    }
    [self setNeedsDisplay];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self isPassword];
}
- (void)drawRect:(CGRect)rect{
    if (self.buttonsArray.count <= 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.buttonsArray.count; i++) {
        UIButton *btn = self.buttonsArray[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:_movePoint];
    [[UIColor greenColor] set];
    path.lineWidth = 3;
    path.lineJoinStyle = kCGLineJoinRound;
    
    // 渲染到视图
    [path stroke];
    
}
//判断是否是正确的密码
- (void)isPassword
{
    if (self.buttonsArray.count <= 0) {
        return;
    }
    NSMutableString *passwordString=[[NSMutableString alloc] init];
    for (UIButton *button in self.buttonsArray) {
        [passwordString appendFormat:@"%ld",button.tag-LockViewButtonTag];
    }
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
#ifdef OTHERUSE
    NSString *password1=[ud objectForKey:PassWordOne] ? [ud objectForKey:PassWordOne] : @"1234";
    NSString *password2=[ud objectForKey:PassWordOne] ? [ud objectForKey:PassWordOne] : @"1234";
#else
    NSString *password1=[ud objectForKey:PassWordOne] ? [ud objectForKey:PassWordOne] : @"24658";
    NSString *password2=[ud objectForKey:PassWordTwo] ? [ud objectForKey:PassWordTwo] : @"028635147";
#endif
    if ([passwordString isEqualToString:password1] || [passwordString isEqualToString:password2]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PasswordIsYES object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:PasswordIsWrong object:nil];
    }
}
// 获取触摸按钮
- (UIButton *)buttonWithPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)){ // 点在按钮上
            return btn;
        }
    }
    
    return nil;
}
//不是第一次画线
- (void)isFirstDraw
{
    [self renewOriginalStatus];
}
- (void)renewOriginalStatus
{
    if (self.buttonsArray.count > 0) {
        for (UIButton *button in self.buttonsArray) {
            button.selected=NO;
        }
        [self.buttonsArray removeAllObjects];
    }
    [self setNeedsDisplay];
}
#pragma mark - UI
//XIB是一个文件，加载的时候会进行解析
// 解析Xib的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 添加按钮
        [self addBtns];
    }
    return self;
}
// 添加按钮
- (void)addBtns
{
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置普通状态下的图片
        [button setImage:[UIImage imageNamedWithFunny:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamedWithFunny:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        // 不允许用户交互
        button.tag = LockViewButtonTag+i;
        button.userInteractionEnabled = NO;
        [self addSubview:button];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat col = 0;
    CGFloat row = 0;
    
    CGFloat btnW = 80;
    CGFloat btnH = 80;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    CGFloat tolCol = 3;
    CGFloat margin = (self.bounds.size.width - tolCol * btnW) / (tolCol + 1);
    // 给按钮设置位置
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        col = i % 3;
        row = i / 3;
        btnX = margin + (margin + btnW) * col;
        btnY = (margin + btnH) * row;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}
#pragma mark - lazy loading
-(NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [[NSMutableArray alloc] init];
    }
    return _buttonsArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
