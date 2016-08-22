//
//  GifShowPicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "GifShowPicturesTableViewCell.h"
#import "HeadView.h"

@interface GifShowPicturesTableViewCell ()
@property (nonatomic, weak) HeadView *headView;
@end
@implementation GifShowPicturesTableViewCell

-(void)pictureConfigOtherUI{
    [self pictureSave:YES];
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    
}

-(void)setModel:(SomeWhatPictureModel *)model{
    _model = model;
    [self.headView headViewWithheadImageUrlString:model.avatar_url name:model.name time:model.create_time.longLongValue];
    
    self.mainTextLabel.text = model.text;
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
    self.mainTextLabel.frame = CGRectMake(10, 65, WIDTH - 20, newSize.height);
    
    CGFloat scale = self.mainImageView.width / model.r_width.intValue;
    CGFloat height=model.r_height.intValue*scale;
    self.mainImageView.frame=CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 5, WIDTH - 20, height);
    [self.mainImageView sd_setImageWithURL:[model.url stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.backView.height = maxY + 8;
    self.rowHeight = maxY + 13;
}

@end
