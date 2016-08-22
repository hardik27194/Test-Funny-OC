//
//  BuDeJiePicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "BuDeJiePicturesTableViewCell.h"
#import "HeadView.h"

@interface BuDeJiePicturesTableViewCell ()
@property (nonatomic, weak) HeadView *headView;
@end
@implementation BuDeJiePicturesTableViewCell

-(void)pictureConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
}

-(void)setModel:(BuDeJiePictureModel *)model{
    _model = model;
    [self.headView headViewWithheadImageUrlString:model.profile_image name:model.name time:[model.create_time timeStringToLongLong]];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.text font:USERTEXTMAINLABELFONT width:WIDTH - 25];
    self.mainTextLabel.text = model.text;
    self.mainTextLabel.height = newSize.height;
    
    CGFloat height=0.0f;
    CGFloat scale=model.width.intValue / (WIDTH - 20);
    height=model.height.intValue/scale;
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 5, WIDTH - 20, height);
    [self.mainImageView sd_setImageWithURL:[model.cdn_img stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 10;
}

@end
