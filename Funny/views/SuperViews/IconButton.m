//
//  IconButton.m
//  Funny
//
//  Created by yanzhen on 16/5/19.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 12;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.titleLabel.frame = CGRectMake(0, self.width + 5, self.width, 20);
}

@end
