//
//  ContentTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "ContentTextTableViewCell.h"
#import "ContentOtherUserView.h"
#import "HeadView.h"

@interface ContentTextTableViewCell ()
@property (nonatomic, weak) HeadView *headView;
@end

@implementation ContentTextTableViewCell

- (void)textConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
    
    ContentOtherUserView *smallView = [[ContentOtherUserView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainTextLabel.frame) + 10, WIDTH - 20, 0)];
    [self.contentView addSubview:smallView];
    self.smallView = smallView;
}

-(void)setTextModel:(ContentTextModel *)textModel{
    _textModel = textModel;
    [self.smallView smallViewWithOriginY:CGRectGetMaxY(self.mainTextLabel.frame) + 5 headImageViewUrlString:textModel.avatar_url name:textModel.user_name text:textModel.text];
    CGFloat maxY = CGRectGetMaxY(self.smallView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 7.5;
}

- (void)setGroupModel:(ContextTextGroupModel *)groupModel{
    _groupModel = groupModel;
    [self.headView headViewWithheadImageUrlString:groupModel.user[@"avatar_url"] name:groupModel.user[@"name"] time:groupModel.create_time];
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:groupModel.text font: USERTEXTMAINLABELFONT width:WIDTH - 25];
    self.mainTextLabel.text = groupModel.text;
    self.mainTextLabel.frame = CGRectMake(15.0, 65.0, WIDTH - 25, newSize.height);
    CGFloat maxY = CGRectGetMaxY(self.mainTextLabel.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 7.5;
}


@end
