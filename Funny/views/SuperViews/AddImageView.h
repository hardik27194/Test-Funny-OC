//
//  AddImageView.h
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddImageViewCellDelegate <NSObject>

- (void)selectAtTableView:(NSInteger)index;

@end
@interface AddImageView : UIImageView
@property (weak, nonatomic) id<AddImageViewCellDelegate>delegate;
@property (assign, nonatomic) BOOL isAddImageViewHidden;

- (void)toggleAddImageView;

@end
