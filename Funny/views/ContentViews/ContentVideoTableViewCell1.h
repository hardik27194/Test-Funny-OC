//
//  ContentVideoTableViewCell1.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyVideoTableViewCell.h"

@class ContentOtherUserView;
@interface ContentVideoTableViewCell1 : FunnyVideoTableViewCell
@property (nonatomic, weak) ContentOtherUserView *smallView;
@property (strong, nonatomic) ContentVideoGroupModel *groupModel;
@property (strong, nonatomic) ContentVideoCommentsModel *commentModel;
@end
