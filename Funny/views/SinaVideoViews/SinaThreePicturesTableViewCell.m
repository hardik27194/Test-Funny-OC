//
//  SinaThreePicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SinaThreePicturesTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SinaThreePicturesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation SinaThreePicturesTableViewCell

-(void)setModel:(SinaNewsModel *)model
{
    _model=model;
    UIImage *image=[[UIImage imageNamed:@"Y&Z"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _titleLab.text=model.title;
    NSArray *listArray=model.pics[@"list"];
    NSString *imageAddresss1=listArray[0][@"kpic"];
    NSString *imageAddresss2=listArray[1][@"kpic"];
    NSString *imageAddresss3=listArray[2][@"kpic"];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imageAddresss1] placeholderImage:image];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString:imageAddresss2] placeholderImage:image];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:imageAddresss3] placeholderImage:image];
}

@end
