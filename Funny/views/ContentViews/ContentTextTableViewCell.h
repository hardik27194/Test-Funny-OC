//
//  ContentTextTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyTextTableViewCell.h"

@class ContentOtherUserView;
@interface ContentTextTableViewCell : FunnyTextTableViewCell

@property (nonatomic, weak) ContentOtherUserView *smallView;
@property (strong, nonatomic) ContentTextModel *textModel;
@property (strong, nonatomic) ContextTextGroupModel *groupModel;

@end
