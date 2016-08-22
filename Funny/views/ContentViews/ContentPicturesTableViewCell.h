//
//  ContentPicturesTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyPictureTableViewCell.h"

@class ContentOtherUserView;
@interface ContentPicturesTableViewCell : FunnyPictureTableViewCell

@property (nonatomic, weak) ContentOtherUserView *smallView;
@property (strong, nonatomic) ContentPictureGroupModel *groupModel;
@property (strong, nonatomic) ContentPictureCommentModel *commentModel;

@end
