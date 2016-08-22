//
//  BuDeJieVideoTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "BuDeJieVideoTableViewCell1.h"
#import "HeadView.h"

@interface BuDeJieVideoTableViewCell1 ()
@property (nonatomic, weak) HeadView *headView;
@property (nonatomic, weak) UILabel *mainTextLabel;
@end

@implementation BuDeJieVideoTableViewCell1

-(void)funnyVideoConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    
    UILabel *mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0)];
    mainTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
    mainTextLabel.numberOfLines = 0;
    [self.contentView addSubview:mainTextLabel];
    self.mainTextLabel = mainTextLabel;
}

-(void)setModel:(BuDeJieVideoModel *)model{
    _model = model;
    [self.headView headViewWithheadImageUrlString:model.profile_image name:model.name time:[model.create_time timeStringToLongLong]];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.text font:USERTEXTMAINLABELFONT width:WIDTH - 25];
    self.shareTitle = self.mainTextLabel.text = model.text;
    self.shareURL = model.videouri;
    self.mainTextLabel.height = newSize.height;
    
    CGFloat height = 0.0f;
    CGFloat scale  = model.width.intValue / self.mainImageView.width;
    height         = model.height.intValue/scale;
    [self.mainImageView sd_setImageWithURL:[model.bimageuri stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 5, WIDTH - 20, height);
    self.playBtn.frame = CGRectMake(self.mainImageView.maxX - 70, self.mainImageView.maxY - 62, 70, 62);
    CGFloat maxY = self.mainImageView.maxY;
    self.progressView.y = maxY;
    self.backView.height = maxY + 7;
    self.rowHeight = maxY + 12;
}

@end
