//
//  DrawPictureImageView.h
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendImageBlock)(UIImage *image);
@interface DrawPictureImageView : UIView<UIGestureRecognizerDelegate>
@property (copy, nonatomic) SendImageBlock block;
@property (strong, nonatomic) UIImage *image;
- (void)drawInPictureStart;
@end
