//
//  NEThreePicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NEThreePicturesTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NEThreePicturesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
@implementation NEThreePicturesTableViewCell

-(void)setModel:(NetEaseDefaultModel *)model
{
    _model=model;
    UIImage *image=[[UIImage imageNamed:@"Y&Z"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _titleLab.text=model.title;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:image];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString:model.imgextra[0][@"url"]] placeholderImage:image];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:model.imgextra[1][@"url"]] placeholderImage:image];
}

@end
