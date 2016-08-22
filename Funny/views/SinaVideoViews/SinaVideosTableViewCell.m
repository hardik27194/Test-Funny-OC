//
//  SinaVideosTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaVideosTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SinaVideosTableViewCell
{
    UIView *_backView;
    UILabel *_titleLab;
    UILabel *_yzLabel;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [self confUI];
    }
    return self;
}
- (void)confUI
{
    _backView=[[UIView alloc] initWithFrame:CGRectMake(0, 5, WIDTH, 265)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_backView];
    //
    _mainImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, 210)];
    [self.contentView addSubview:_mainImageView];
    
    _yzLabel=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH-70, 5, 65, 25)];
    _yzLabel.backgroundColor=[UIColor lightGrayColor];
    _yzLabel.text=@"Y&Z TV";
    _yzLabel.font=[UIFont systemFontOfSize:14];
    _yzLabel.textColor=[UIColor redColor];
    _yzLabel.textAlignment=NSTextAlignmentCenter;
    [_mainImageView addSubview:_yzLabel];
    
    _playButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _playButton.center=_mainImageView.center;
    [_playButton setImage:[UIImage imageNamedWithFunny:@"play"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_playButton];
    //
    _progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mainImageView.frame), WIDTH, 2)];
    [_progressView setProgress:0.0f];
    [self.contentView addSubview:_progressView];
    _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 235, WIDTH-20, 25)];
    [self.contentView addSubview:_titleLab];
    
}
-(void)setModel:(SinaVideoModel *)model
{
    _model=model;
    UIImage *image=[[UIImage imageNamedWithHZW:@"大熊_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:image];
    _titleLab.text=model.title;
}

- (void)playButtonAction:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(playButtonClick:)]) {
        [_delegate playButtonClick:sender];
    }
}
@end
