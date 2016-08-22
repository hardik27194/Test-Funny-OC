//
//  ContentVideoTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "ContentVideoTableViewCell1.h"
#import "ContentOtherUserView.h"
#import "HeadView.h"

@interface ContentVideoTableViewCell1 ()
@property (nonatomic, weak) HeadView *headView;
@property (nonatomic, weak) UILabel *userStateLabel;
@end

@implementation ContentVideoTableViewCell1

-(void)setGroupModel:(ContentVideoGroupModel *)groupModel{
    _groupModel = groupModel;
    [self.headView headViewWithheadImageUrlString:groupModel.avatar_url name:groupModel.name time:groupModel.create_time.longLongValue];
    if (groupModel.text) {
        CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:groupModel.text font:USERTEXTMAINLABELFONT width:WIDTH - 20];
        self.userStateLabel.text = groupModel.text;
        self.userStateLabel.height = newSize.height;
    }
    self.shareURL = groupModel.url;
    self.shareTitle = groupModel.text;
    UIImage *image = [UIImage imageNamedWithHZW:@"大熊_1"];
    CGFloat originW = groupModel.width.longLongValue ? groupModel.width.longValue : 1;
    CGFloat originH = groupModel.height.longLongValue;
    CGFloat scale   = (WIDTH - 20.0) / originW;
    originH *= scale;
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.userStateLabel.frame), WIDTH - 20, originH);
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:groupModel.imageURL] placeholderImage:image];
    
    CGFloat maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.playBtn.frame = CGRectMake(self.mainImageView.maxX - 70, maxY - 62, 70, 62);
    self.progressView.frame = CGRectMake(10, maxY, WIDTH - 20, 2);
    self.backView.height = maxY + 9;
    self.rowHeight = maxY + 11.5;
}

- (void)setCommentModel:(ContentVideoCommentsModel *)commentModel{
    _commentModel = commentModel;
    [self.smallView smallViewWithOriginY:CGRectGetMaxY(self.mainImageView.frame) + 10 headImageViewUrlString:commentModel.avatar_url name:commentModel.user_name text:commentModel.text];
    CGFloat maxY = CGRectGetMaxY(self.smallView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 7.5;
}


- (void)funnyVideoConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    UILabel *userTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0)];
    userTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
    userTextLabel.numberOfLines = 0;
    [self.contentView addSubview:userTextLabel];
    self.userStateLabel = userTextLabel;
    
    ContentOtherUserView *smallView = [[ContentOtherUserView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainImageView.frame) + 10, WIDTH - 20, 0)];
    [self.contentView addSubview:smallView];
    self.smallView = smallView;
}
@end
