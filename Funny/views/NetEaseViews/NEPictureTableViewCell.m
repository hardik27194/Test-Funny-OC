//
//  NEPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NEPictureTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NEPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *onlyImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end
@implementation NEPictureTableViewCell


-(void)setModel:(NetEaseDefaultModel *)model
{
    _model=model;
    UIImage *image=[[UIImage imageNamedWithHZW:@"small"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _titleLab.text=model.title;
    _subTitleLabel.text=model.digest;
    [_onlyImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:image];
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end