//
//  ShotPartScreenView.h
//  Funny
//
//  Created by yanzhen on 15/12/8.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShotPartBlock)(BOOL shot,CGRect rect);
@interface ShotPartScreenView : UIView
@property (nonatomic, copy) ShotPartBlock block;
@end
