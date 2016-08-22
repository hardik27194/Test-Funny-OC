//
//  SinaVideosTableViewCell.h
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SinaVideoPlayClickDelegate <NSObject>

- (void)playButtonClick:(UIButton *)button;

@end
@interface SinaVideosTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *mainImageView;
@property (nonatomic, strong) SinaVideoModel *model;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIProgressView *progressView;
@property (weak, nonatomic) id<SinaVideoPlayClickDelegate>delegate;

@end
