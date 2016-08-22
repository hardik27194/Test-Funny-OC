//
//  FunnyVideoTableViewCell.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnySuperTableViewCell.h"

@class FunnyVideoTableViewCell;
@protocol VideoPlayDelegate <NSObject>

@optional
- (void)videoPlay:(BOOL)play videoCell:(FunnyVideoTableViewCell *)videoCell;
/**          暂停和播放状态才能到window播放             */
- (void)playVideoOnWindow:(FunnyVideoTableViewCell *)cell;
@end

@interface FunnyVideoTableViewCell : FunnySuperTableViewCell
@property (nonatomic, weak) UIImageView *mainImageView;
@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UIProgressView *progressView;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, weak) id<VideoPlayDelegate> delegate;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) BOOL isPause;
@property (nonatomic, readonly) BOOL refresh;

- (void)funnyVideoConfigOtherUI;
@end
