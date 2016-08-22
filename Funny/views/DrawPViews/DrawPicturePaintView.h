//
//  DrawPicturePaintView.h
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPicturePaintView : UIView
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) UIImage *image;


- (void)clearScreen;

- (void)undo;
- (BOOL)isDrawInView;
@end
