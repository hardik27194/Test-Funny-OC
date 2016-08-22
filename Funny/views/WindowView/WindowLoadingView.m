//
//  WindowLoadingView.m
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "WindowLoadingView.h"

@interface WindowLoadingView ()

@end

@implementation WindowLoadingView
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_tipLabel.hidden) {
        self.hidden = YES;
        if (_block) {
            _block();
        }
    }
}

- (void)configUI{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.hidesWhenStopped = YES;
    indicator.color = YZColor(255, 155, 23);
    [self addSubview:indicator];
    _indicator = indicator;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"加载失败";
    tipLabel.hidden = YES;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = YZColor(255, 155, 23);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _indicator.center = CGPointMake(self.width * 0.5, self.height * 0.5 - 7);
    _tipLabel.frame = CGRectMake(0, self.height - 25, self.width, 25);
}

@end
