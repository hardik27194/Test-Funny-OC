//
//  ExtensionButton.m
//  Today Extension
//
//  Created by yanzhen on 16/10/11.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "ExtensionButton.h"

@implementation ExtensionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 12;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    self.imageView.frame = CGRectMake(0, 0, 60, 60);
    self.imageView.center = CGPointMake(width * 0.5, 37.5);
    
    self.titleLabel.frame = CGRectMake(0, 65 + 5, width, 20);
}

@end
