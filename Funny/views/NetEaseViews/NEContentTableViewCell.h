//
//  NEContentTableViewCell.h
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEContentTableViewCell : UITableViewCell
@property (nonatomic, strong) NetEaseDefaultModel *model;
@property (nonatomic, readonly) CGFloat rowHeight;
@end
