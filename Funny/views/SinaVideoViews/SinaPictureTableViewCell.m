//
//  SinaPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaPictureTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SinaPictureTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *onlyImageView;
@end
@implementation SinaPictureTableViewCell

-(void)setModel:(SinaNewsModel *)model
{
    _model=model;
    UIImage *image=[[UIImage imageNamed:@"Y&Z"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _titleLab.text=model.title;
    _subTitleLabel.text=model.intro;
    [_onlyImageView sd_setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:image];
    
}

@end
