//
//  BuDEJieTextTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "BuDEJieTextTableViewCell1.h"
#import "HeadView.h"

@interface BuDEJieTextTableViewCell1 ()
@property (nonatomic, weak) HeadView *headView;
@end
@implementation BuDEJieTextTableViewCell1

-(void)textConfigOtherUI{
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 50)];
    [self.contentView addSubview:headView];
    self.headView = headView;
}

-(void)setModel:(BuDeJieTextModel *)model{
    _model = model;
    [self.headView headViewWithheadImageUrlString:model.profile_image name:model.name time:[model.create_time timeStringToLongLong]];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.text font:USERTEXTMAINLABELFONT width:WIDTH - 25];
    self.mainTextLabel.text = model.text;
    self.mainTextLabel.height = newSize.height;
    
    CGFloat maxY = CGRectGetMaxY(self.mainTextLabel.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 10;
}

@end
