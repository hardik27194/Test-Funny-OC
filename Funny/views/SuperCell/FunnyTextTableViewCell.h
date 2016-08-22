//
//  FunnyTextTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnySuperTableViewCell.h"

@interface FunnyTextTableViewCell : FunnySuperTableViewCell
@property (nonatomic, weak) UILabel *mainTextLabel;

- (void)textConfigOtherUI;
@end
