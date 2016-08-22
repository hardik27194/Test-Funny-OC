//
//  DrawPicturePath.h
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPicturePath : UIBezierPath
@property (nonatomic, strong) UIColor *color;
+ (instancetype)paintPathWithLineWidth:(CGFloat)width color:(UIColor *)color startPoint:(CGPoint)startPoint;
@end
