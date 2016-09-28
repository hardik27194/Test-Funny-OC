//
//  ContentPicturesTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "ContentPicturesTableViewCell.h"
#import "ContentOtherUserView.h"
#import "HeadView.h"

@interface ContentPicturesTableViewCell ()
@property (nonatomic, weak) HeadView *headView;
@end

@implementation ContentPicturesTableViewCell

- (void)pictureConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    
    ContentOtherUserView *smallView = [[ContentOtherUserView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 10, WIDTH - 20, 0)];
    [self.contentView addSubview:smallView];
    self.smallView = smallView;
}

-(void)setCommentModel:(ContentPictureCommentModel *)commentModel{
    _commentModel = commentModel;
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    [self.smallView smallViewWithOriginY:maxY + 5 headImageViewUrlString:commentModel.avatar_url name:commentModel.user_name text:commentModel.text];
    maxY = CGRectGetMaxY(self.smallView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 7.5;
}

-(void)setGroupModel:(ContentPictureGroupModel *)groupModel{
    _groupModel = groupModel;
    [self.headView headViewWithheadImageUrlString:groupModel.avatar_url name:groupModel.name time:groupModel.create_time.longLongValue];
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:groupModel.text font:USERTEXTMAINLABELFONT width:WIDTH - 25];
    self.mainTextLabel.text = groupModel.text;
    self.mainTextLabel.frame = CGRectMake(15.0, 65.0, WIDTH - 25, newSize.height);
    
    UIImage *image = [UIImage imageNamed:@"Y&Z"];
    CGFloat originW = groupModel.r_width.longLongValue ? groupModel.r_width.longLongValue : 1;
    CGFloat originH = groupModel.r_height.longLongValue;
    CGFloat scale   = (WIDTH - 20.0) / originW;
    originH *= scale;
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 5, WIDTH - 20, originH);
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:groupModel.url] placeholderImage:image];
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 7.5;
}

@end
