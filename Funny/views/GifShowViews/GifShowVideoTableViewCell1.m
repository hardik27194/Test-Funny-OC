//
//  GifShowVideoTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "GifShowVideoTableViewCell1.h"
#import "HeadView.h"

@interface GifShowVideoTableViewCell1 ()
@property (nonatomic, weak) HeadView *headView;
@end
@implementation GifShowVideoTableViewCell1

-(void)funnyVideoConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    self.rightSpace = 170;
}

-(void)setModel:(GifShowVideoModel *)model{
    _model = model;
    [self.headView headViewWithheadImageUrlString:model.main_url name:model.user_name time:[model.time timeStringToLongLong]];
    self.shareURL = model.main_mv_url;
    CGFloat mainHeight = (WIDTH - 100) / 3 * 4;
    self.mainImageView.frame = CGRectMake(50.0, 70.0, WIDTH - 100.0, mainHeight);
    [self.mainImageView sd_setImageWithURL:[model.thumbnail_url stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.progressView.frame = CGRectMake(self.mainImageView.x, maxY, WIDTH - 100, 2);
    self.playBtn.frame = CGRectMake(self.mainImageView.maxX - 70, maxY - 62, 70, 62);
    self.backView.height = maxY + 8;
    self.rowHeight = maxY + 13;
    
}

@end
