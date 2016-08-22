//
//  FunnySuperTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunnySuperTableViewCell : UITableViewCell
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, assign) CGFloat rowHeight;

- (void)funnySuperOtherView;
@end
