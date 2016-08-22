//
//  WindowLoadingView.h
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WindowLoadingViewBlock)();

@interface WindowLoadingView : UIView
@property (nonatomic, weak, readonly) UIActivityIndicatorView *indicator;
@property (nonatomic, weak, readonly) UILabel *tipLabel;
@property (nonatomic, copy) WindowLoadingViewBlock block;
@end
