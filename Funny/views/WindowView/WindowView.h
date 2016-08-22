//
//  WindowView.h
//  Funny
//
//  Created by yanzhen on 16/7/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WindowViewDelegate <NSObject>

- (void)closeWindowView;
- (void)videoPlayOrPause:(UIButton *)playBtn;
- (void)loadingViewDismissForFail;
@end

@class WindowLoadingView;
@interface WindowView : UIView
@property (nonatomic, weak, readonly) UIImageView *mainImageView;
@property (nonatomic, weak, readonly) UIProgressView *progressView;
@property (nonatomic, weak, readonly) UIButton *playBtn;
@property (nonatomic, weak, readonly) WindowLoadingView *loadingView;
@property (nonatomic, weak) id<WindowViewDelegate> delegate;

@end
