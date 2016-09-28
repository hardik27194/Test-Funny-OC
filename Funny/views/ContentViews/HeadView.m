//
//  HeadView.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()
@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *creatTimeLabel;
@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.width / 2;
    [self addSubview:imageView];
    self.headImageView = imageView;
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 5.0, 200.0, 20.0)];
    userNameLabel.font = [UIFont systemFontOfSize:USERNAMELABELFONT];
    [self addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    
    UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 25.0, 200.0, 20.0)];
    creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
    [self addSubview:creatTimeLabel];
    self.creatTimeLabel = creatTimeLabel;
}

-(void)headViewWithheadImageUrlString:(NSString *)headImageUrlString name:(NSString *)name time:(long long)time{
    UIImage *image = [UIImage imageNamed:@"Y&Z"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageUrlString] placeholderImage:image];
    self.userNameLabel.text = name;
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:time];
}

@end
