//
//  AboutManageFPViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/10.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutManageFPViewController.h"

@interface AboutManageFPViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *mLabel;
@property (nonatomic, strong) CAGradientLayer* gradientLayer;
@property (nonatomic, assign) BOOL leftToRight;

@end

@implementation AboutManageFPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"提示";
    NSString *tipString=@"联系管理员获得初始密码\nContact your administrator to get a list of collection passwords";
    
    _leftToRight = YES;
    
    UILabel *label=[[UILabel alloc] init];
    label.numberOfLines=0;
    label.text=tipString;
    label.font=[UIFont systemFontOfSize:17];
    CGSize newSize=[tipString boundingRectWithSize:CGSizeMake(WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    label.frame=CGRectMake(10, 80, WIDTH-20, newSize.height);
    [self.view addSubview:label];
    
    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame)+10, WIDTH-20, 25)];
    myLabel.text=@"----- Admin";
    myLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:myLabel];
    _mLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(myLabel.frame)+10, WIDTH-20, 40)];
    _mLabel.text=[NSString dateString];
    _mLabel.textAlignment=NSTextAlignmentCenter;
    _mLabel.font = [UIFont systemFontOfSize:25];
    _mLabel.center=CGPointMake(WIDTH/2, HEIGHT/2);
    [self.view addSubview:_mLabel];
    
    NSArray *colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor blackColor].CGColor];
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _mLabel.frame;
    gradientLayer.colors = colors;
    //坐标的最后必须保持一致
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.mask = _mLabel.layer;
    _mLabel.frame = gradientLayer.bounds;
    _gradientLayer = gradientLayer;
    
    [self.timer setFireDate:[NSDate distantPast]];
    
}

-(NSTimer *)timer
{
    if (!_timer) {
        _timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)updateTime
{
    _mLabel.text=[NSString dateString];
    static CGFloat i = 0;
    if (_leftToRight) {
        i += 0.1;
        if (i > 1) {
            i = 0.9;
            _leftToRight = NO;
        }
    }else{
        i -= 0.1;
        if (i < 0) {
            i = 0.1;
            _leftToRight = YES;
        }
    }
    _gradientLayer.endPoint = CGPointMake(i, 1);
}
@end
