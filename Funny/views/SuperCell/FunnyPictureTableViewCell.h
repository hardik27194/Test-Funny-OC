//
//  FunnyPictureTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnySuperTableViewCell.h"

@interface FunnyPictureTableViewCell : FunnySuperTableViewCell

@property (nonatomic, weak) UILabel *mainTextLabel;
@property (nonatomic, weak) UIImageView *mainImageView;

- (void)pictureConfigOtherUI;
- (void)pictureSave:(BOOL)isSave;
@end
