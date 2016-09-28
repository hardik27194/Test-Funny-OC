//
//  ContentOtherUserView.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "ContentOtherUserView.h"
#import "UIImageView+WebCache.h"

#define OTHERUSERTEXTLABELFONT 17.0
@interface ContentOtherUserView ()
@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *userTextLabel;
@end

@implementation ContentOtherUserView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YZColor(246, 246, 256);
        self.clipsToBounds = YES;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    UILabel *tipLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 37, 18)];
    tipLabel.backgroundColor=[UIColor colorWithRed:251/255.0 green:95/255.0 blue:136/255.0 alpha:1];
    tipLabel.textAlignment=NSTextAlignmentCenter;
    tipLabel.textColor=[UIColor whiteColor];
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.text=@"神评论";
    [self addSubview:tipLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 30.0, 25.0, 25.0)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.width / 2;
    [self addSubview:imageView];
    self.headImageView = imageView;
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 30.0, 200.0, 25.0)];
    userNameLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:userNameLabel];
    self.userNameLabel = userNameLabel;
    
    UILabel *userTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 60.0, WIDTH - 70.0, 0.0)];
    userTextLabel.numberOfLines = 0;
    userTextLabel.font = [UIFont systemFontOfSize:OTHERUSERTEXTLABELFONT];
    [self addSubview:userTextLabel];
    self.userTextLabel = userTextLabel;
}

-(void)smallViewWithOriginY:(CGFloat)originY headImageViewUrlString:(NSString *)userHeadUrlString name:(NSString *)name text:(NSString *)text{
    self.y = originY;
    
    UIImage *image = [UIImage imageNamed:@"Y&Z"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userHeadUrlString] placeholderImage:image];
    self.userNameLabel.text = name;
    self.userTextLabel.text = text;
    
    CGSize size = [[GlobalManage shareGlobalManage] labelSize:text font:OTHERUSERTEXTLABELFONT width:WIDTH - 68.0];
    self.userTextLabel.height = size.height;
    self.height = size.height + 85.0;
}

@end
